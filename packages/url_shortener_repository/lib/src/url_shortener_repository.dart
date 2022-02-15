import 'package:url_shortener_api/url_shortener_api.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

/// A type representing either a [UrlShortenerFailure] or a [OriginalUrl].
typedef OriginalUrlResult = Result<UrlShortenerFailure, OriginalUrl>;

/// A type representing either a [UrlShortenerFailure] or a [ShortenedUrl].
typedef ShortenedUrlResult = Result<UrlShortenerFailure, ShortenedUrl>;

/// A data source for functionality related to url shortening.
/// Exposes a set of methods to interact with the [UrlShortenerApi] client.
/// Should map all exceptions to the strongly typed [UrlShortenerFailure].
abstract class UrlShortenerRepository {
  /// Retrieves the original url for the given [aliasId].
  Future<OriginalUrlResult> getOriginalUrl({
    required String aliasId,
  });

  /// Shortens a given [originalUrl] and returns the result.
  Future<ShortenedUrlResult> shortenUrl({
    required OriginalUrl originalUrl,
  });
}

/// {@template url_shortener_respository}
/// A concrete implementation of [UrlShortenerRepository].
/// {@endtemplate}
class UrlShortenerRepositoryImpl implements UrlShortenerRepository {
  /// {@macro url_shortener_respository}
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
