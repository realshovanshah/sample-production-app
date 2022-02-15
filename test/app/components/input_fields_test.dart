import 'package:flutter_test/flutter_test.dart';
import 'package:link_shortener/app/components/input_fields.dart';

void main() {
  test('isEmptyOrNull', () {
    expect(isEmptyOrNull(null), true);
    expect(isEmptyOrNull(''), true);
    expect(isEmptyOrNull(' '), true);
    expect(isEmptyOrNull('any-value'), false);
    expect(isEmptyOrNull('any value'), false);
  });
}
