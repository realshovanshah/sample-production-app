import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_shortener_api/url_shortener_api.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

class MockUrlShortenerApi extends Mock implements UrlShortenerApi {}

void main() {
  group('UrlShortenerRepository', () {
    late MockUrlShortenerApi _urlShortenerApi;
    late OriginalUrl _originalUrlModel;
    late ShortenedUrl _shortenedUrlModel;
    late UrlShortenerRepository _repository;
    const _aliasId = 'valid-alias-id';
    const _originalUrl = 'https://www.test.com';
    const _shortUrl = 'https://www.test.com';

    setUp(() {
      _urlShortenerApi = MockUrlShortenerApi();
      _repository =
          UrlShortenerRepositoryImpl(urlShortenerApi: _urlShortenerApi);
      _originalUrlModel = const OriginalUrl(url: _originalUrl);
      _shortenedUrlModel = const ShortenedUrl(
        aliasId: _aliasId,
        link: Links(url: _originalUrl, short: _shortUrl),
      );
    });

    test('instantiates', () {
      expect(_repository, isA<UrlShortenerRepository>());
    });

    group('.getOriginalUrl', () {
      test('correctly returns the original url', () async {
        Future<OriginalUrl> _mockRequest() => _urlShortenerApi.getOriginalUrl(
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

        Future<OriginalUrl> _mockRequest() => _urlShortenerApi.getOriginalUrl(
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
        Future<OriginalUrl> _mockRequest() => _urlShortenerApi.getOriginalUrl(
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
        Future<OriginalUrl> _mockRequest() => _urlShortenerApi.getOriginalUrl(
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
        Future<ShortenedUrl> _mockRequest() => _urlShortenerApi.shortenUrl(
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
          () => _urlShortenerApi.shortenUrl(originalUrl: _originalUrlModel),
        ).called(1);
      });

      test('should return a UrlShortenerFailure on exceptions', () async {
        Future<ShortenedUrl> _mockRequest() => _urlShortenerApi.shortenUrl(
              originalUrl: _originalUrlModel,
            );
        when(_mockRequest).thenThrow(Exception());

        final result =
            await _repository.shortenUrl(originalUrl: _originalUrlModel);
        expect(
          result,
          Result<UrlShortenerFailure, ShortenedUrl>.failure(
            UrlShortenerFailure(),
          ),
        );

        verify(
          () => _urlShortenerApi.shortenUrl(originalUrl: _originalUrlModel),
        ).called(1);
      });

      test('should return a UrlShortenerFailure with same message on exception',
          () async {
        const error = 'error message';
        Future<ShortenedUrl> _mockRequest() => _urlShortenerApi.shortenUrl(
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
  });
}
