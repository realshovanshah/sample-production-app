import 'package:bloc_test/bloc_test.dart';
import 'package:equatable_stack/equatable_stack.dart';
import 'package:flutter/material.dart'
    show CircularProgressIndicator, Form, SnackBar, TextFormField;
import 'package:flutter_test/flutter_test.dart';
import 'package:link_shortener/app/app.dart';
import 'package:link_shortener/features/url_shortener/models/models.dart';
import 'package:link_shortener/features/url_shortener/state/state.dart';
import 'package:link_shortener/features/url_shortener/view/view.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/helpers.dart';

class MockUrlShortenerCubit extends MockCubit<UrlShortenerState>
    implements UrlShortenerCubit {}

void main() {
  group('UrlShortenerFooter', () {
    late MockUrlShortenerCubit _cubit;
    setUp(() {
      _cubit = MockUrlShortenerCubit();
      when(() => _cubit.state).thenReturn(UrlShortenerState.idle());
      when(() => _cubit.shortenUrl(any())).thenAnswer((_) async {});
    });

    testWidgets(
      'renders a Form with a TextField and an Action Button',
      (tester) async {
        await tester.pumpAppWithDependencies(
          const ShortenUrlFooter(),
          cubit: _cubit,
        );

        expect(find.byType(Form), findsOneWidget);
        expect(find.byType(TextFormField), findsOneWidget);
        expect(find.byType(ActionButton), findsOneWidget);
      },
    );

    testWidgets(
      'shortenUrl on cubit if not invoked if the text invalid',
      (tester) async {
        const invalidText = ' ';
        await tester.pumpAppWithDependencies(
          const ShortenUrlFooter(),
          cubit: _cubit,
        );
        await tester.enterText(find.byType(TextFormField), invalidText);
        await tester.tap(find.byType(ActionButton));

        verifyNever(() => _cubit.shortenUrl(invalidText));
      },
    );

    testWidgets('shows a snackbar with error msg on failure ', (tester) async {
      const _errorMsg = 'err';
      final _mockRecents = Stack.of(
        const [UrlModel(original: 'any-long', shortened: 'any-short')],
      );
      whenListen(
        _cubit,
        Stream.fromIterable([
          UrlShortenerState.loading(recents: _mockRecents),
          UrlShortenerState.failure(recents: _mockRecents, message: _errorMsg),
        ]),
      );
      await tester.pumpAppWithDependencies(
        const ShortenUrlFooter(),
        cubit: _cubit,
      );
      await tester.pumpAndSettle();
      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text(_errorMsg), findsOneWidget);
    });

    testWidgets(
      'shows a action button on initial state',
      (tester) async {
        when(() => _cubit.state).thenReturn(
          UrlShortenerState.idle(),
        );
        await tester.pumpAppWithDependencies(
          const ShortenUrlFooter(),
          cubit: _cubit,
        );
        await tester.pumpAndSettle();
        expect(find.byType(ActionButton), findsOneWidget);
      },
    );

    testWidgets(
      'shows a copy button on success state',
      (tester) async {
        final _mockRecents = Stack.of(
          const [UrlModel(original: 'any-long', shortened: 'any-short')],
        );
        when(() => _cubit.state).thenReturn(
          UrlShortenerState.success(recents: _mockRecents),
        );
        await tester.pumpAppWithDependencies(
          const ShortenUrlFooter(),
          cubit: _cubit,
        );
        await tester.pumpAndSettle();
        expect(find.byType(CopyActionButton), findsOneWidget);
      },
    );
    testWidgets(
      'button loads when the state is loading',
      (tester) async {
        final _mockRecents = Stack<UrlModel>();
        when(() => _cubit.state).thenReturn(
          UrlShortenerState.loading(recents: _mockRecents),
        );
        await tester.pumpAppWithDependencies(
          const ShortenUrlFooter(),
          cubit: _cubit,
        );
        await tester.enterText(find.byType(TextFormField), 'valid-text');
        await tester.tap(find.byType(ActionButton));
        expect(find.byType(CircularProgressIndicator), findsOneWidget);
      },
    );

    testWidgets(
      //todo:
      'button changes from loading to copy state when the state is success',
      (tester) async {
        final _mockRecents = Stack.of(
          const [UrlModel(original: 'any-long', shortened: 'any-short')],
        );
        const _pumpDuration = Duration(seconds: 1);
        final _states = [
          UrlShortenerState.loading(recents: _mockRecents),
          UrlShortenerState.success(recents: _mockRecents)
        ];
        whenListen(
          _cubit,
          Stream.periodic(_pumpDuration, (i) => _states[i]).take(2),
        );

        await tester.pumpAppWithDependencies(
          const ShortenUrlFooter(),
          cubit: _cubit,
        );

        await tester.pump(_pumpDuration);
        expect(find.byType(CircularProgressIndicator), findsOneWidget);

        await tester.pumpAndSettle(_pumpDuration);
        expect(find.byType(CopyActionButton), findsOneWidget);
        expect(find.byType(CircularProgressIndicator), findsNothing);
      },
    );

    testWidgets(
      'resetStatus is called when the CopyActionButton is tapped',
      (tester) async {
        final _mockRecents = Stack.of(
          const [UrlModel(original: 'any-long', shortened: 'any-short')],
        );
        when(() => _cubit.state).thenReturn(
          UrlShortenerState.success(recents: _mockRecents),
        );
        when(_cubit.resetStatus).thenReturn(null);

        await tester.pumpAppWithDependencies(
          const ShortenUrlFooter(),
          cubit: _cubit,
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byType(CopyActionButton));

        verify(_cubit.resetStatus).called(1);
      },
    );

    // testWidgets('fills the text field with url on success', (tester) {});

    testWidgets(
      'clears the text field when the CopyActionButton is tapped',
      (tester) async {
        const mockText = 'mock-text';
        final _mockRecents = Stack<UrlModel>.of(
          const [UrlModel(original: 'mock-url', shortened: 'mock-short-url')],
        );
        when(() => _cubit.state).thenReturn(
          UrlShortenerState.success(recents: _mockRecents),
        );
        await tester.pumpAppWithDependencies(
          const ShortenUrlFooter(),
          cubit: _cubit,
        );

        await tester.enterText(find.byType(TextFormField), mockText);
        expect(find.text(mockText), findsOneWidget);

        await tester.tap(find.byType(CopyActionButton));
        await tester.pumpAndSettle();
        // the state should be success by now
        expect(find.text(mockText), findsNothing);
      },
    );
  });
}
