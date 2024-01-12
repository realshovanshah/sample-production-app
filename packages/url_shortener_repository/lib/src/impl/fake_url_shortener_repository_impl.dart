import 'package:url_shortener_api/url_shortener_api.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

/// {@template fake_url_shortener_repository}
/// A fake implementation of [UrlShortenerRepository].
/// Useful for testing purposes. Has a default delay of 2 seconds.
/// {@endtemplate}
class FakeUrlShortenerRepositoryImpl implements UrlShortenerRepository {
  /// {@macro fake_url_shortener_repository}
  const FakeUrlShortenerRepositoryImpl({int? delay}) : _delay = delay ?? 2;

  final int _delay;

  // fake data  (todo: create realistic data)

  static const _aliasId = 'alias-id';
  static const _originalUrl = 'https://www.test.com';
  static const _shortUrl = 'https://www.test.com';

  static const OriginalUrl _originalUrlModel = OriginalUrl(url: _originalUrl);
  static const ShortenedUrl _shortenedUrlModel = ShortenedUrl(
    aliasId: _aliasId,
    link: Links(url: _originalUrl, short: _shortUrl),
  );

  @override
  Future<OriginalUrlResult> getOriginalUrl({
    required String aliasId,
  }) async {
    return Future.delayed(
      Duration(seconds: _delay),
      () => const Result.success(_originalUrlModel),
    );
  }

  @override
  Future<ShortenedUrlResult> shortenUrl({
    required OriginalUrl originalUrl,
  }) async {
    return Future.delayed(
      Duration(seconds: _delay),
      () => const Result.success(_shortenedUrlModel),
    );
  }

  @override
  AllUrlResult getShortenedUrls() {
    Future.delayed(Duration(seconds: _delay), () {});
    return const Result.success(
      [UrlModel(original: _originalUrl, shortened: _shortUrl)],
    );
  }
}
