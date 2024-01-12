import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_shortener_api/url_shortener_api.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

class MockUrlShortenerRemoteApi extends Mock implements UrlShortenerRemoteApi {}

class MockUrlShortenerLocalApi extends Mock implements UrlShortenerLocalApi {}

void main() {
  group('UrlShortenerRepositoryImpl', () {
    late MockUrlShortenerRemoteApi _remoteApi;
    late MockUrlShortenerLocalApi _localApi;
    late OriginalUrl _originalUrlModel;
    late ShortenedUrl _shortenedUrlModel;
    late UrlShortenerRepository _repository;
    const _aliasId = 'valid-alias-id';
    const _originalUrl = 'https://www.test.com';
    const _shortUrl = 'https://www.test.com';

    setUpAll(() {
      registerFallbackValue(const OriginalUrl(url: 'https://www.test.com'));
      registerFallbackValue(
        const UrlModel(original: 'https://www.test.com', shortened: 'tst.com'),
      );
    });

    setUp(() {
      _remoteApi = MockUrlShortenerRemoteApi();
      _localApi = MockUrlShortenerLocalApi();
      _repository = UrlShortenerRepositoryImpl(
        urlShortenerRemoteApi: _remoteApi,
        urlShortenerLocalApi: _localApi,
      );
      _originalUrlModel = const OriginalUrl(url: _originalUrl);
      _shortenedUrlModel = const ShortenedUrl(
        aliasId: _aliasId,
        link: Links(url: _originalUrl, short: _shortUrl),
      );
    });

    test('correct apis provided, instantiates', () {
      expect(_repository, isA<UrlShortenerRepository>());
    });

    group('.getOriginalUrl', () {
      test('correctly returns the original url', () async {
        Future<OriginalUrl> _mockRequest() => _remoteApi.getOriginalUrl(
              aliasId: _aliasId,
            );
        when(_mockRequest).thenAnswer((_) async => _originalUrlModel);

        final result = await _repository.getOriginalUrl(aliasId: _aliasId);
        expect(
          result,
          Result<UrlShortenerFailure, OriginalUrl>.success(_originalUrlModel),
        );

        verify(_mockRequest).called(1);
      });

      test('should return a UrlShortenerFailure if the alias does not exist',
          () async {
        const _errorMsg = 'Alias does not exist';
        const _badAliasId = 'bad-alias-id';

        Future<OriginalUrl> _mockRequest() => _remoteApi.getOriginalUrl(
              aliasId: _badAliasId,
            );
        when(_mockRequest)
            .thenThrow(const InvalidRequestException(404, _errorMsg));

        final result = await _repository.getOriginalUrl(aliasId: _badAliasId);
        expect(
          result,
          Result<UrlShortenerFailure, OriginalUrl>.failure(
            UrlShortenerFailure(_errorMsg),
          ),
        );

        verify(_mockRequest).called(1);
      });

      test('should return a UrlShortenerFailure on exceptions', () async {
        Future<OriginalUrl> _mockRequest() => _remoteApi.getOriginalUrl(
              aliasId: _aliasId,
            );
        when(_mockRequest).thenThrow(Exception());

        final result = await _repository.getOriginalUrl(aliasId: _aliasId);
        expect(
          result,
          Result<UrlShortenerFailure, OriginalUrl>.failure(
            UrlShortenerFailure(),
          ),
        );

        verify(_mockRequest).called(1);
      });

      test('should return a UrlShortenerFailure with same message on exception',
          () async {
        Future<OriginalUrl> _mockRequest() => _remoteApi.getOriginalUrl(
              aliasId: _aliasId,
            );
        const error = 'error message';
        when(_mockRequest).thenThrow(const NetworkException(error));

        final result = await _repository.getOriginalUrl(aliasId: _aliasId);
        expect(
          result,
          Result<UrlShortenerFailure, OriginalUrl>.failure(
            UrlShortenerFailure(error),
          ),
        );

        verify(_mockRequest).called(1);
      });
    });

    group('.shortenUrl', () {
      test('correctly returns success with a shortened url', () async {
        Future<ShortenedUrl> _mockRequest() => _remoteApi.shortenUrl(
              originalUrl: _originalUrlModel,
            );
        when(_mockRequest).thenAnswer((_) async => _shortenedUrlModel);
        final result =
            await _repository.shortenUrl(originalUrl: _originalUrlModel);
        expect(
          result,
          Result<UrlShortenerFailure, ShortenedUrl>.success(_shortenedUrlModel),
        );
        verify(
          () => _remoteApi.shortenUrl(originalUrl: _originalUrlModel),
        ).called(1);
      });

      test('caches the returned url', () async {
        when(
          () => _remoteApi.shortenUrl(originalUrl: any(named: 'originalUrl')),
        ).thenAnswer((_) async => _shortenedUrlModel);
        void _mockRequest() => _localApi.cacheShortenedUrl(
              url: any(named: 'url'),
            );
        when(_mockRequest).thenReturn(null);
        await _repository.shortenUrl(originalUrl: _originalUrlModel);
        verify(_mockRequest).called(1);
      });

      test('should return a UrlShortenerFailure on exceptions', () async {
        Future<ShortenedUrl> _mockRequest() => _remoteApi.shortenUrl(
              originalUrl: _originalUrlModel,
            );
        when(_mockRequest).thenThrow(const BadResponseException());

        final result =
            await _repository.shortenUrl(originalUrl: _originalUrlModel);
        expect(
          result,
          isA<Result<UrlShortenerFailure, ShortenedUrl>>().having(
            (p0) => p0.when(success: (_) => false, failure: (_) => true),
            'failure',
            true,
          ),
        );

        verify(
          () => _remoteApi.shortenUrl(originalUrl: _originalUrlModel),
        ).called(1);
      });

      test('should return a UrlShortenerFailure with same message on exception',
          () async {
        const error = 'error message';
        Future<ShortenedUrl> _mockRequest() => _remoteApi.shortenUrl(
              originalUrl: _originalUrlModel,
            );
        when(_mockRequest).thenThrow(const NetworkException(error));
        final result =
            await _repository.shortenUrl(originalUrl: _originalUrlModel);

        expect(
          result,
          Result<UrlShortenerFailure, ShortenedUrl>.failure(
            UrlShortenerFailure(error),
          ),
        );
        verify(_mockRequest).called(1);
      });
    });

    group('.getAllUrls', () {
      test('correctly returns all the urls', () async {
        const _recents = [
          UrlModel(original: 'https://www.test.com', shortened: 'tst.com'),
          UrlModel(original: 'https://www.test.com', shortened: 'tst.com'),
        ];
        Iterable<UrlModel> _mockRequest() => _localApi.getAllUrls();
        when(_mockRequest).thenReturn(_recents);

        final result = _repository.getShortenedUrls();
        expect(
          result,
          const Result<UrlShortenerFailure, Iterable<UrlModel>>.success(
            _recents,
          ),
        );

        verify(_mockRequest).called(1);
      });

      test('should return a UrlShortenerFailure on exceptions', () async {
        Iterable<UrlModel> _mockRequest() => _localApi.getAllUrls();
        when(_mockRequest).thenThrow(const BadResponseException());

        final result = _repository.getShortenedUrls();
        expect(
          result,
          isA<Result<UrlShortenerFailure, Iterable<UrlModel>>>().having(
            (p0) => p0.when(success: (_) => false, failure: (_) => true),
            'failure',
            true,
          ),
        );

        verify(_mockRequest).called(1);
      });
    });
  });
}
