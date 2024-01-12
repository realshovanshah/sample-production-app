import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_shortener_api/url_shortener_api.dart';

class MockHive extends Mock implements HiveInterface {}

class MockBox<UrlModel> extends Mock implements Box<UrlModel> {}

void main() {
  group('UrlShortenerLocalApi', () {
    late HiveInterface _hive;
    late MockBox<UrlModel> _box;
    late final UrlShortenerLocalApi _subject;
    late final UrlModel _mockUrlModel;

    setUpAll(() {
      _hive = MockHive();
      _box = MockBox<UrlModel>();
      _mockUrlModel = const UrlModel(
        original: 'long-url',
        shortened: 'short-url',
      );
      when(() => _hive.openBox<UrlModel>(any())).thenAnswer(
        (_) async => _box,
      );
      when(() => _hive.box<UrlModel>(any())).thenReturn(_box);
      _subject = UrlShortenerLocalApi(hive: _hive);
    });

    test('instantiates', () {
      final instance = UrlShortenerLocalApi(hive: _hive);
      expect(instance, isA<UrlShortenerLocalApi>());
    });

    group('.cacheUrlModel', () {
      test('adds a shortened URL to cache', () async {
        when(() => _box.add(_mockUrlModel)).thenAnswer((_) async => 0);

        _subject.cacheShortenedUrl(url: _mockUrlModel);
        verify(() => _box.add(_mockUrlModel)).called(1);
      });
    });

    group('.getAllUrlModels', () {
      test('returns all cached shortened URLs', () async {
        when(() => _box.values).thenReturn([_mockUrlModel]);
        final result = _subject.getAllUrls();
        expect(result, equals([_mockUrlModel]));
      });
    });

    test('adds a shortened url to the existing list of cache.', () {
      const existingUrlModel = UrlModel(
        original: 'long-url',
        shortened: 'short-url',
      );
      when(() => _box.values).thenReturn([existingUrlModel]);
      when(() => _box.add(_mockUrlModel)).thenAnswer((_) async => 0);

      _subject.cacheShortenedUrl(url: _mockUrlModel);
      verify(() => _box.add(_mockUrlModel)).called(1);
    });
  });
}
