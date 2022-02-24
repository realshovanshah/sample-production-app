import 'package:hive/hive.dart';
import 'package:meta/meta.dart';
import 'package:url_shortener_api/url_shortener_api.dart';

/// {@template url_shortener_local_api}
/// A local implementation of the UrlShortenerApi that uses
/// local storage to fetch and store the shortened urls.
/// {@endtemplate}
class UrlShortenerLocalApi {
  /// {@macro url_shortener_local_api}
  UrlShortenerLocalApi({required HiveInterface hive}) : _hive = hive {
    _hive.openBox<ShortenedUrl>(kBoxUrl);
  }

  /// A open Isar connection.
  final HiveInterface _hive;

  /// Key used to access the shortened urls box.
  /// Not a part of the public api.
  @visibleForTesting
  static const String kBoxUrl = '__shortened_urls__';

  /// Saves the given [url] to the list of shortened urls cache.
  void cacheShortenedUrl(ShortenedUrl url) =>
      _hive.box<ShortenedUrl>(kBoxUrl).add(url);

  /// Returns all the shortened urls from the cache.
  /// todo: set a limit on the max cache size.
  Iterable<ShortenedUrl> getAllShortenedUrls() =>
      _hive.box<ShortenedUrl>(kBoxUrl).values;
}
