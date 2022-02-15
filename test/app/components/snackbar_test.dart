import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_shortener/app/components/components.dart';

void main() {
  group('Snackbar', () {
    late SnackBar _snackBar;

    setUp(() {
      _snackBar = buildCustomSnackbar(
        message: 'any message',
        status: SnackbarStatus.success,
      );
    });

    test('instantiates', () {
      expect(_snackBar, isA<SnackBar>());
    });
  });
}
