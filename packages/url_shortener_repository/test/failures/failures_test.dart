import 'package:flutter_test/flutter_test.dart';
import 'package:url_shortener_repository/src/failures/failures.dart';

void main() {
  group('UrlShortenerFailure', () {
    test('instantiates', () {
      expect(
        UrlShortenerFailure('failure-msg'),
        UrlShortenerFailure('failure-msg'),
      );
    });

    test('toString', () {
      expect(
        UrlShortenerFailure('failure-msg').toString(),
        'UrlShortenerFailure(message: failure-msg)',
      );
    });

    test('equals', () {
      final failure1 = UrlShortenerFailure('failure-msg');
      final failure2 = UrlShortenerFailure('failure-msg');
      expect(failure1, failure2);
      expect(failure1.hashCode, failure2.hashCode);
    });
  });
}
