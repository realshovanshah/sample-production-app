import 'package:flutter_test/flutter_test.dart';
import 'package:url_shortener_api/url_shortener_api.dart';

void main() {
  group('UrlModel', () {
    test('supports value comparison', () {
      const model1 =
          UrlModel(original: 'https://www.test.com', shortened: 'test');
      const model2 =
          UrlModel(original: 'https://www.test.com', shortened: 'test');
      expect(model1, model2);
      expect(model1.hashCode, model2.hashCode);
    });

    test('has a fromEntity method, correct', () {
      expect(
        UrlModel.fromEntity(
          const ShortenedUrl(
            link: Links(short: 'test.co', url: 'https://www.test.com'),
            aliasId: '1',
          ),
        ),
        const UrlModel(original: 'https://www.test.com', shortened: 'test.co'),
      );
    });

    test('overrides toString method', () {
      const _url = UrlModel(
        original: 'https://www.test.com',
        shortened: 'test',
      );
      expect(_url.toString(), contains('${_url.runtimeType}'));
    });
  });
}
