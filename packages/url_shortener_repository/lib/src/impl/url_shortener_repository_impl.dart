import 'package:url_shortener_api/url_shortener_api.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

/// {@template url_shortener_repository}
/// An implementation of the [UrlShortenerRepository].
/// {@endtemplate}
class UrlShortenerRepositoryImpl implements UrlShortenerRepository {
  /// {@macro url_shortener_repository}
  UrlShortenerRepositoryImpl({
    UrlShortenerApi? urlShortenerApi,
  }) : _urlShortenerApi = urlShortenerApi ?? UrlShortenerApi();

  final UrlShortenerApi _urlShortenerApi;

  @override
  Future<OriginalUrlResult> getOriginalUrl({
    required String aliasId,
  }) async {
    try {
      final response = await _urlShortenerApi.getOriginalUrl(aliasId: aliasId);
      return Result.success(response);
      // only [Exception] type is thrown by the api
    } on Exception catch (e) {
      return Result.failure(e.mapToFailure());
    }
  }

  @override
  Future<ShortenedUrlResult> shortenUrl({
    required OriginalUrl originalUrl,
  }) async {
    try {
      final response =
          await _urlShortenerApi.shortenUrl(originalUrl: originalUrl);
      return Result.success(response);
    } on Exception catch (e) {
      return Result.failure(e.mapToFailure());
    }
  }
}

extension on Exception {
  UrlShortenerFailure mapToFailure() {
    switch (runtimeType) {
      case NetworkException:
        return UrlShortenerFailure(
          (this as NetworkException).message ?? 'A network error occurred.',
        );

      case InvalidRequestException:
        return UrlShortenerFailure(
          (this as InvalidRequestException).message ??
              'The given request was invalid.',
        );

      case BadResponseException:
        return UrlShortenerFailure(
          (this as BadResponseException).message ??
              'Received an unexpected response.',
        );
      default:
        return UrlShortenerFailure();
    }
  }
}
