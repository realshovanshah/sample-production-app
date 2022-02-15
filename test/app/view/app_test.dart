import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_shortener/app/app.dart';
import 'package:link_shortener/features/url_shortener/view/view.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_shortener_repository/url_shortener_repository.dart';

import '../../helpers/helpers.dart';

class MockUrlShortenerRepository extends Mock
    implements UrlShortenerRepository {}

void main() {
  late UrlShortenerRepository _repository;

  setUp(() {
    _repository = MockUrlShortenerRepository();
  });

  testWidgets('renders correctly', (tester) async {
    await tester.pumpWidget(
      App(urlShortenerRepository: _repository),
    );
    expect(find.byType(AppView), findsOneWidget);
  });

  group('AppView', () {
    testWidgets('renders UrlShortenerPage', (tester) async {
      await tester.pumpWidget(
        App(urlShortenerRepository: _repository),
      );
      expect(find.byType(UrlShortenerPage), findsOneWidget);
    });

    testWidgets('contains a MaterialApp', (tester) async {
      await tester.pumpWidgetWithDependencies(
        const AppView(),
        repository: _repository,
      );
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}
