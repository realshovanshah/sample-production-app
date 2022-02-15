import 'package:bloc_test/bloc_test.dart';
import 'package:equatable_stack/equatable_stack.dart';
import 'package:flutter/material.dart' show ListTile, ListView;
import 'package:flutter_test/flutter_test.dart';
import 'package:link_shortener/features/url_shortener/models/url_model.dart';
import 'package:link_shortener/features/url_shortener/state/state.dart';
import 'package:link_shortener/features/url_shortener/view/view.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

class MockUrlShortenerCubit extends MockCubit<UrlShortenerState>
    implements UrlShortenerCubit {}

void main() {
  group('RecentUrlList', () {
    late MockUrlShortenerCubit _cubit;
    setUp(() {
      _cubit = MockUrlShortenerCubit();
      when(() => _cubit.state).thenReturn(UrlShortenerState.idle());
      when(() => _cubit.shortenUrl(any())).thenAnswer((_) async {});
    });

    test('instantiates', () {
      const widget = RecentUrlList();
      expect(widget, isA<RecentUrlList>());
    });

    testWidgets('Show empty message on initial state', (tester) async {
      await tester.pumpAppWithDependencies(
        const RecentUrlList(),
        cubit: _cubit,
      );
      await tester.pumpAndSettle();

      expect(find.text('No recently shortened URLs.'), findsOneWidget);
    });

    testWidgets('Show empty message when the recents is empty', (tester) async {
      when(() => _cubit.state).thenReturn(
        UrlShortenerState.success(recents: Stack<UrlModel>()),
      );
      await tester.pumpAppWithDependencies(
        const RecentUrlList(),
        cubit: _cubit,
      );
      await tester.pumpAndSettle();

      expect(find.text('No recently shortened URLs.'), findsOneWidget);
    });

    testWidgets('Loads data the recents is populated', (tester) async {
      final _mockRecents = Stack.of(
        const [
          UrlModel(original: 'any-long', shortened: 'any-short'),
          UrlModel(original: 'any-long', shortened: 'short-url'),
        ],
      );
      when(() => _cubit.state).thenReturn(
        UrlShortenerState.success(recents: _mockRecents),
      );
      await tester.pumpAppWithDependencies(
        const RecentUrlList(),
        cubit: _cubit,
      );
      await tester.pump();

      expect(find.byType(ListView), findsOneWidget);
      expect(find.byType(ListTile), findsNWidgets(_mockRecents.length));
    });

    testWidgets('new url is added to the top of the list ', (tester) async {
      const _shortUrl = 'short-url';
      const _emitDuration = Duration(seconds: 1);

      final _states = [
        UrlShortenerState.success(
          recents: Stack.of(
            const [UrlModel(original: 'any-long', shortened: 'any-short')],
          ),
        ),
        UrlShortenerState.success(
          recents: Stack.of(
            const [
              UrlModel(original: 'any-long', shortened: 'any-short'),
              UrlModel(original: 'any-long', shortened: _shortUrl), // pushed
            ],
          ),
        ),
      ];
      whenListen(
        _cubit,
        Stream.periodic(_emitDuration, (i) => _states[i]).take(2),
      );
      await tester.pumpAppWithDependencies(
        const RecentUrlList(),
        cubit: _cubit,
      );

      await tester.pump(_emitDuration);
      expect(find.byType(ListTile), findsOneWidget);

      await tester.pump(_emitDuration);
      expect(find.byType(ListTile), findsNWidgets(2));
    });

    group('RecentUrlTile', () {
      testWidgets('renders original and shortened url', (tester) async {
        when(() => _cubit.state).thenReturn(
          UrlShortenerState.success(
            recents: Stack.of(
              const [UrlModel(original: 'original', shortened: 'shortened')],
            ),
          ),
        );

        await tester.pumpAppWithDependencies(
          const RecentUrlList(),
          cubit: _cubit,
        );
        expect(find.text('original'), findsOneWidget);
        expect(find.text('shortened'), findsOneWidget);
      });
    });
  });
}
