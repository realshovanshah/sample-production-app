import 'package:bloc_test/bloc_test.dart';
import 'package:equatable_stack/equatable_stack.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_shortener/features/url_shortener/models/url_model.dart';
import 'package:link_shortener/features/url_shortener/state/state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_shortener_api/url_shortener_api.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

class MockUrlShortenerRepository extends Mock
    implements UrlShortenerRepository {}

void main() {
  const _originalUrl = 'https://www.any.com';
  const _shortUrl = 'https://any.cm/';
  const _aliasId = 'mock-alias-id';

  setUpAll(() {
    registerFallbackValue(const OriginalUrl(url: 'any-url'));
  });
  group('UrlShortenerCubit', () {
    late UrlShortenerRepository _repository;
    const _shortenedUrlModel = ShortenedUrl(
      aliasId: _aliasId,
      link: Links(url: _originalUrl, short: _shortUrl),
    );
    const _urlModel = UrlModel(original: _originalUrl, shortened: _shortUrl);

    setUp(() {
      _repository = MockUrlShortenerRepository();
      when(() => _repository.shortenUrl(originalUrl: any(named: 'originalUrl')))
          .thenAnswer(
        (_) async => const Result<UrlShortenerFailure, ShortenedUrl>.success(
          _shortenedUrlModel,
        ),
      );
    });

    test('instantiates', () {
      expect(
        UrlShortenerCubit(urlShortenerRepository: _repository),
        isA<UrlShortenerCubit>(),
      );
    });

    test('initial state is UrlShortenerInitial', () {
      expect(
        UrlShortenerCubit(urlShortenerRepository: _repository).state,
        equals(UrlShortenerState.idle(recents: Stack())),
      );
    });

    late Stack<UrlModel> _recents;
    setUp(() {
      _recents = Stack.of(
        const [UrlModel(original: 'original', shortened: 'shortened')],
      );
    });
    group('.urlShortened', () {
      const _mockErrorMsg = 'mock-error-msg';
      blocTest<UrlShortenerCubit, UrlShortenerState>(
        'emits a success state with the shortened url',
        build: () {
          return UrlShortenerCubit(urlShortenerRepository: _repository);
        },
        act: (cubit) async {
          await cubit.urlShortened('mock-url');
        },
        expect: () => <UrlShortenerState>[
          UrlShortenerState.loading(recents: Stack()),
          UrlShortenerState.success(recents: Stack.of(const [_urlModel]))
        ],
      );

      blocTest<UrlShortenerCubit, UrlShortenerState>(
        'emits a success state and adds the url on top of the existing queue',
        build: () {
          return UrlShortenerCubit(urlShortenerRepository: _repository);
        },
        act: (cubit) async {
          await cubit.urlShortened('mock-url');
        },
        seed: () => UrlShortenerState.success(recents: _recents),
        expect: () => <UrlShortenerState>[
          UrlShortenerState.loading(recents: _recents),
          UrlShortenerState.success(
            recents: _recents.copyWith(UrlModel.fromEntity(_shortenedUrlModel)),
          ),
        ],
      );

      blocTest<UrlShortenerCubit, UrlShortenerState>(
        'emits a failure state when the repository throws an error',
        build: () {
          return UrlShortenerCubit(urlShortenerRepository: _repository);
        },
        act: (cubit) async {
          when(
            () =>
                _repository.shortenUrl(originalUrl: any(named: 'originalUrl')),
          ).thenAnswer(
            (_) async => Result<UrlShortenerFailure, ShortenedUrl>.failure(
              UrlShortenerFailure(_mockErrorMsg),
            ),
          );
          await cubit.urlShortened('mock-url');
        },
        expect: () => <UrlShortenerState>[
          UrlShortenerState.loading(recents: Stack()),
          UrlShortenerState.failure(recents: Stack(), message: _mockErrorMsg),
        ],
      );

      blocTest<UrlShortenerCubit, UrlShortenerState>(
        'emits a failure state and also preserves the data and the error msg',
        build: () {
          return UrlShortenerCubit(urlShortenerRepository: _repository);
        },
        act: (cubit) async {
          when(
            () =>
                _repository.shortenUrl(originalUrl: any(named: 'originalUrl')),
          ).thenAnswer(
            (_) async => Result<UrlShortenerFailure, ShortenedUrl>.failure(
              UrlShortenerFailure(_mockErrorMsg),
            ),
          );
          await cubit.urlShortened('mock-url');
        },
        seed: () => UrlShortenerState.success(recents: _recents),
        expect: () => <UrlShortenerState>[
          UrlShortenerState.loading(recents: _recents),
          UrlShortenerState.failure(recents: _recents, message: _mockErrorMsg),
        ],
      );
    });

    group('.urlCleared', () {
      blocTest<UrlShortenerCubit, UrlShortenerState>(
        'if cleared url was shorted url, changes to initial state',
        build: () {
          return UrlShortenerCubit(urlShortenerRepository: _repository);
        },
        act: (cubit) {
          final _shortenedUrl = _recents.peek.shortened;
          cubit.urlCleared(
            _shortenedUrl.substring(0, _shortenedUrl.length - 1),
          );
        },
        seed: () => UrlShortenerState.success(recents: _recents),
        expect: () => <UrlShortenerState>[
          UrlShortenerState.idle(recents: _recents),
        ],
      );

      blocTest<UrlShortenerCubit, UrlShortenerState>(
        'if cleared url was not shorted, does not change to initial state',
        build: () {
          return UrlShortenerCubit(urlShortenerRepository: _repository);
        },
        act: (cubit) {
          cubit.urlCleared(_recents.peek.shortened);
        },
        seed: () => UrlShortenerState.success(recents: _recents),
        expect: () => <UrlShortenerState>[],
      );
    });

    group('.textCopied', () {
      blocTest<UrlShortenerCubit, UrlShortenerState>(
        'emits initial State, retains state',
        build: () {
          return UrlShortenerCubit(urlShortenerRepository: _repository);
        },
        act: (cubit) async {
          cubit.textCopied();
        },
        seed: () => UrlShortenerState.success(recents: _recents),
        expect: () => <UrlShortenerState>[
          UrlShortenerState.idle(recents: _recents),
        ],
      );
    });
  });
}
