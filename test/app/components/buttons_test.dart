import 'package:flutter/material.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:link_shortener/app/components/components.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockCallback extends Mock {
  void call();
}

class MockValueGetter extends Mock {
  String call();
}

void main() {
  group('ActionButton', () {
    test('instantiates', () {
      expect(ActionButton(onTap: () {}), isA<ActionButton>());
    });

    testWidgets('renders itself correctly', (tester) async {
      await tester.pumpMaterialWidget(ActionButton(onTap: () {}));

      expect(find.byType(IconButton), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('calls the correct callback when tapped', (tester) async {
      final _mockCallback = MockCallback();
      when(_mockCallback.call).thenReturn(null);

      await tester.pumpMaterialWidget(ActionButton(onTap: _mockCallback.call));
      await tester.tap(find.byType(ActionButton));

      verify(_mockCallback.call).called(1);
    });

    testWidgets('renders loading state correctly', (tester) async {
      await tester
          .pumpMaterialWidget(ActionButton(onTap: () {}, loading: true));
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('the callback is disabled when loading', (tester) async {
      final _mockCallback = MockCallback();
      when(_mockCallback.call).thenReturn(null);

      await tester.pumpMaterialWidget(
        ActionButton(onTap: _mockCallback.call, loading: true),
      );
      await tester.tap(find.byType(ActionButton));

      verifyNever(_mockCallback.call);
    });
  });

  group('CopyActionButton', () {
    test('instantiates', () {
      expect(CopyActionButton(onTap: () => 'any'), isA<CopyActionButton>());
    });

    testWidgets('renders itself correctly', (tester) async {
      await tester.pumpMaterialWidget(CopyActionButton(onTap: () => ''));

      expect(find.byType(InkWell), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

    testWidgets('calls the correct callback when tapped', (tester) async {
      final _mockValueGetter = MockValueGetter();
      when(_mockValueGetter.call).thenReturn('');

      await tester
          .pumpMaterialWidget(CopyActionButton(onTap: _mockValueGetter.call));
      await tester.tap(find.byType(CopyActionButton));

      verify(_mockValueGetter.call).called(1);
    });
  });
}
