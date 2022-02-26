import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_shortener_api/url_shortener_api.dart';

class MockDio extends Mock implements Dio {}

void main() {
  group('UrlShortenerApiClient', () {
    late UrlShortenerRemoteApi _api;
    late Dio _dio;

    const _originalUrl = 'http://mock.url';
    const _shortenedUrl = 'http://mk.ul';
    const _goodAliasId = '123';
    const _badAliasId = 'bad-alias-id';

    late OriginalUrl _originalUrlModel;
    late JsonMap _originalUrlData;
    late ShortenedUrl _shortenedUrlModel;

    setUp(() {
      _dio = MockDio();
      _api = UrlShortenerRemoteApi(dio: _dio);

      _originalUrlModel = const OriginalUrl(url: _originalUrl);
      _originalUrlData = _originalUrlModel.toJson();
      _shortenedUrlModel = const ShortenedUrl(
        aliasId: _goodAliasId,
        link: Links(url: _originalUrl, short: _shortenedUrl),
      );
    });

    group('instantiation', () {
      test('client provided', () {
        expect(_api, isA<UrlShortenerRemoteApi>());
      });

      test('no client provided', () {
        expect(UrlShortenerRemoteApi(), isA<UrlShortenerRemoteApi>());
      });
    });

    group('.getOriginalUrl', () {
      late String _goodUrl;
      late String _badUrl;
      late RequestOptions _goodRequestOptions;
      late RequestOptions _badRequestOptions;

      setUp(() {
        _goodUrl = '${UrlShortenerRemoteApi.aliasUrl}/$_goodAliasId';
        _badUrl = '${UrlShortenerRemoteApi.aliasUrl}/$_badAliasId';
        _goodRequestOptions = RequestOptions(path: _goodUrl);
        _badRequestOptions = RequestOptions(path: _badUrl);
      });

      test('returns the original url if the alias id exists', () async {
        Future<Response<JsonMap>> _mockRequest() => _dio.get<JsonMap>(_goodUrl);
        when(_mockRequest).thenAnswer(
          (_) async => Response<JsonMap>(
            data: _originalUrlModel.toJson(),
            statusCode: 200,
            requestOptions: _goodRequestOptions,
          ),
        );

        expect(
          _api.getOriginalUrl(aliasId: _goodAliasId),
          completion(equals(_originalUrlModel)),
        );
        verify(_mockRequest).called(1);
      });

      test('throws a FailedRequestException if the alias id does not exist',
          () async {
        Future<Response<JsonMap>> _mockRequest() => _dio.get<JsonMap>(_badUrl);
        when(_mockRequest).thenAnswer(
          (_) async => Response<JsonMap>(
            statusCode: 404,
            requestOptions: _badRequestOptions,
          ),
        );

        expect(
          () async => _api.getOriginalUrl(aliasId: _badAliasId),
          throwsA(isA<InvalidRequestException>()),
        );
        verify(_mockRequest).called(1);
      });

      test('throws a FailedRequestException on incorrect status codes',
          () async {
        Future<Response<JsonMap>> _mockRequest() => _dio.get<JsonMap>(_goodUrl);
        when(_mockRequest).thenAnswer(
          (_) async => Response<JsonMap>(
            statusCode: 503,
            requestOptions: _goodRequestOptions,
          ),
        );

        expect(
          () async => _api.getOriginalUrl(aliasId: _goodAliasId),
          throwsA(isA<InvalidRequestException>()),
        );
        verify(_mockRequest).called(1);
      });

      test('throws a BadResponseException on incorrect response type',
          () async {
        Future<Response<String>> _mockRequest() => _dio.get<String>(_goodUrl);
        when(_mockRequest).thenAnswer(
          (_) async => Response<String>(
            data: 'unexpected-response',
            statusCode: 200,
            requestOptions: _goodRequestOptions,
          ),
        );

        expect(
          () async => _api.getOriginalUrl(aliasId: _goodAliasId),
          throwsA(isA<BadResponseException>()),
        );
        verify(_mockRequest).called(1);
      });

      test('throws a BadResponseException on incorrect response data',
          () async {
        Future<Response<JsonMap>> _mockRequest() => _dio.get<JsonMap>(_goodUrl);
        when(_mockRequest).thenAnswer(
          (_) async => Response<JsonMap>(
            data: <String, dynamic>{'unexpected-data': 'unexpected-data'},
            statusCode: 200,
            requestOptions: _goodRequestOptions,
          ),
        );

        expect(
          () async => _api.getOriginalUrl(aliasId: _goodAliasId),
          throwsA(isA<BadResponseException>()),
        );
        verify(_mockRequest).called(1);
      });

      test('throws a NetworkException on Dio errors', () async {
        Future<Response<JsonMap>> _mockRequest() => _dio.get<JsonMap>(_goodUrl);

        when(_mockRequest).thenThrow(
          DioError(
            error: DioErrorType.connectTimeout,
            requestOptions: _goodRequestOptions,
          ),
        );
        expect(
          () async => _api.getOriginalUrl(aliasId: _goodAliasId),
          throwsA(isA<NetworkException>()),
        );

        when(_mockRequest).thenThrow(
          DioError(
            error: DioErrorType.other,
            requestOptions: _goodRequestOptions,
          ),
        );
        expect(
          () async => _api.getOriginalUrl(aliasId: _goodAliasId),
          throwsA(isA<NetworkException>()),
        );

        verify(_mockRequest).called(2);
      });
    });

    group('.shortenUrl', () {
      late String _urlShortenerPath;

      setUp(() {
        _urlShortenerPath = UrlShortenerRemoteApi.aliasUrl;
      });

      test('returns a shortened url on correct request', () async {
        Future<Response<JsonMap>> _mockRequest() => _dio.post<JsonMap>(
              _urlShortenerPath,
              data: _originalUrlData,
            );
        when(_mockRequest).thenAnswer(
          (_) async => Response<JsonMap>(
            data: _shortenedUrlModel.toJson(),
            statusCode: 200,
            requestOptions: RequestOptions(path: _urlShortenerPath),
          ),
        );

        expect(
          _api.shortenUrl(originalUrl: _originalUrlModel),
          completion(equals(_shortenedUrlModel)),
        );
        verify(_mockRequest).called(1);
      });

      test('throws a FailedRequestException on incorrect status codes',
          () async {
        Future<Response<JsonMap>> _mockRequest() => _dio.post<JsonMap>(
              _urlShortenerPath,
              data: _originalUrlData,
            );
        when(_mockRequest).thenAnswer(
          (_) async => Response<JsonMap>(
            data: _shortenedUrlModel.toJson(),
            statusCode: 503,
            requestOptions: RequestOptions(path: _urlShortenerPath),
          ),
        );
        expect(
          () async => _api.shortenUrl(originalUrl: _originalUrlModel),
          throwsA(isA<InvalidRequestException>()),
        );
        verify(_mockRequest).called(1);
      });

      test('throws a BadResponseException on incorrect response', () async {
        Future<Response<String>> _mockRequest() => _dio.post<String>(
              _urlShortenerPath,
              data: _originalUrlData,
            );
        when(_mockRequest).thenAnswer(
          (_) async => Response<String>(
            data: 'unexpected-response',
            statusCode: 200,
            requestOptions: RequestOptions(path: _urlShortenerPath),
          ),
        );

        expect(
          () async => _api.shortenUrl(originalUrl: _originalUrlModel),
          throwsA(isA<BadResponseException>()),
        );
        verify(_mockRequest).called(1);
      });

      test('throws a NetworkException on Dio errors', () async {
        Future<Response<JsonMap>> _mockRequest() => _dio.post<JsonMap>(
              _urlShortenerPath,
              data: _originalUrlData,
            );
        when(_mockRequest).thenThrow(
          DioError(
            error: DioErrorType.connectTimeout,
            requestOptions: RequestOptions(path: _urlShortenerPath),
          ),
        );
        expect(
          () async => _api.shortenUrl(originalUrl: _originalUrlModel),
          throwsA(isA<NetworkException>()),
        );

        when(_mockRequest).thenThrow(
          DioError(
            error: DioErrorType.other,
            requestOptions: RequestOptions(path: _urlShortenerPath),
          ),
        );
        expect(
          () async => _api.shortenUrl(originalUrl: _originalUrlModel),
          throwsA(isA<NetworkException>()),
        );

        verify(_mockRequest).called(2);
      });
    });
  });
}
