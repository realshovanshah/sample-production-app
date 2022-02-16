import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  late FlutterDriver _driver;

  setUpAll(() async {
    _driver = await FlutterDriver.connect();
  });

  tearDownAll(() {
    _driver.close();
  });

  test('shortens a url and displays the result', () async {
    const _originalUrl = 'www.test.com';

    final textField = find.byType('TextFormField');
    await _driver.waitFor(textField);
    await _driver.tap(textField);
    await _driver.enterText(_originalUrl);

    final confirmButton = find.byType('ActionButton');
    await _driver.tap(confirmButton);
  });
}
