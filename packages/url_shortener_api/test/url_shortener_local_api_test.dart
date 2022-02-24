import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_shortener_api/url_shortener_api.dart';

class MockHive extends Mock implements HiveInterface {}

class MockBox<ShortenedUrl> extends Mock implements Box<ShortenedUrl> {}

void main() {
  group('UrlShortenerLocalApi', () {
    late HiveInterface _hive;
    late MockBox<ShortenedUrl> _box;
    late final UrlShortenerLocalApi _subject;
    late final ShortenedUrl _mockShortenedUrl;

    setUpAll(() {
      _hive = MockHive();
      _box = MockBox<ShortenedUrl>();
      _mockShortenedUrl = const ShortenedUrl(
        aliasId: '1',
        link: Links(short: 'short-url', url: 'long-url'),
      );
      when(() => _hive.openBox<ShortenedUrl>(any())).thenAnswer(
        (_) async => _box,
      );
      when(() => _hive.box<ShortenedUrl>(any())).thenReturn(_box);
      _subject = UrlShortenerLocalApi(hive: _hive);
    });

    test('instantiates', () {
      final instance = UrlShortenerLocalApi(hive: _hive);
      expect(instance, isA<UrlShortenerLocalApi>());
    });

    group('.cacheShortenedUrl', () {
      test('adds a shortened URL to cache', () async {
        when(() => _box.add(_mockShortenedUrl)).thenAnswer((_) async => 0);

        _subject.cacheShortenedUrl(_mockShortenedUrl);
        verify(() => _box.add(_mockShortenedUrl)).called(1);
      });
    });

    group('.getAllShortenedUrls', () {
      test('returns all cached shortened URLs', () async {
        when(() => _box.values).thenReturn([_mockShortenedUrl]);
        final result = _subject.getAllShortenedUrls();
        expect(result, equals([_mockShortenedUrl]));
      });
    });

    test('adds a shortened url to the existing list of cache.', () {
      const existingShortenedUrl = ShortenedUrl(
        aliasId: '1',
        link: Links(short: 'short-url', url: 'long-url'),
      );
      when(() => _box.values).thenReturn([existingShortenedUrl]);
      when(() => _box.add(_mockShortenedUrl)).thenAnswer((_) async => 0);

      _subject.cacheShortenedUrl(_mockShortenedUrl);
      verify(() => _box.add(_mockShortenedUrl)).called(1);
    });
  });
}
