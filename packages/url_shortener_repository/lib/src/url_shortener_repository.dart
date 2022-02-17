import 'package:url_shortener_api/url_shortener_api.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

/// A type representing either a [UrlShortenerFailure] or a [OriginalUrl].
typedef OriginalUrlResult = Result<UrlShortenerFailure, OriginalUrl>;

/// A type representing either a [UrlShortenerFailure] or a [ShortenedUrl].
typedef ShortenedUrlResult = Result<UrlShortenerFailure, ShortenedUrl>;

/// A repository for all functionality related to url shortening.
/// Exposes a set of methods to interact with the [UrlShortenerApi] client.
/// Should map all exceptions to strongly typed [UrlShortenerFailure]s.
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
