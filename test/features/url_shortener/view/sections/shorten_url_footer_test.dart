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
      when(() => _cubit.state).thenReturn(
        UrlShortenerState.idle(recents: Stack()),
      );
      when(() => _cubit.urlShortened(any())).thenAnswer((_) async {});
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
        await tester.pumpAndSettle();

        verifyNever(() => _cubit.urlShortened(invalidText));
      },
    );

    testWidgets(
      'shows empty error message if the url is empty',
      (tester) async {
        const invalidText = ' ';
        await tester.pumpAppWithDependencies(
          const ShortenUrlFooter(),
          cubit: _cubit,
        );
        await tester.enterText(find.byType(TextFormField), invalidText);
        await tester.tap(find.byType(ActionButton));
        await tester.pumpAndSettle();

        expect(find.text('URL cannot be empty.'), findsOneWidget);
      },
    );

    testWidgets(
      'shows a invalid url error message if the url is invalid',
      (tester) async {
        const invalidText = 'invalid url';
        await tester.pumpAppWithDependencies(
          const ShortenUrlFooter(),
          cubit: _cubit,
        );
        await tester.enterText(find.byType(TextFormField), invalidText);
        await tester.tap(find.byType(ActionButton));
        await tester.pumpAndSettle();

        expect(find.text('Please enter a valid url.'), findsOneWidget);
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
          UrlShortenerState.idle(recents: Stack()),
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

    testWidgets('TextFormField sends text to cubit on change', (tester) async {
      when(() => _cubit.urlCleared(any())).thenReturn(null);
      await tester.pumpAppWithDependencies(
        const ShortenUrlFooter(),
        cubit: _cubit,
      );

      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsOneWidget);
      await tester.enterText(find.byType(TextFormField), 'some-text');

      verify(() => _cubit.urlCleared('some-text')).called(1);
    });

    testWidgets('fills form text field with the shortened url on success',
        (tester) async {
      final _mockRecents = Stack.of(
        const [UrlModel(original: 'any-long', shortened: 'any-short')],
      );
      whenListen(
        _cubit,
        Stream.value(UrlShortenerState.success(recents: _mockRecents)),
      );
      await tester.pumpAppWithDependencies(
        const ShortenUrlFooter(),
        cubit: _cubit,
      );
      await tester.pumpAndSettle();
      expect(find.byType(TextFormField), findsOneWidget);
      expect(find.text('any-short'), findsOneWidget);
    });

    testWidgets(
      'textCopied on cubit is called when the CopyActionButton is tapped',
      (tester) async {
        final _mockRecents = Stack.of(
          const [UrlModel(original: 'any-long', shortened: 'any-short')],
        );
        when(() => _cubit.state).thenReturn(
          UrlShortenerState.success(recents: _mockRecents),
        );
        when(_cubit.textCopied).thenReturn('any');

        await tester.pumpAppWithDependencies(
          const ShortenUrlFooter(),
          cubit: _cubit,
        );
        await tester.pumpAndSettle();
        await tester.tap(find.byType(CopyActionButton));
        await tester.pumpAndSettle();

        verify(_cubit.textCopied).called(1);
      },
    );

    testWidgets(
      'no text in the text field on idle state',
      (tester) async {
        const _mockText = 'any-text';
        final _mockRecents = Stack.of(
          const [UrlModel(original: 'any-long', shortened: 'any-short')],
        );
        const _pumpDuration = Duration(seconds: 1);
        final _states = [
          UrlShortenerState.loading(recents: _mockRecents),
          UrlShortenerState.idle(recents: _mockRecents),
        ];
        whenListen(
          _cubit,
          Stream.periodic(_pumpDuration, (i) => _states[i]).take(2),
        );

        await tester.pumpAppWithDependencies(
          const ShortenUrlFooter(),
          cubit: _cubit,
        );
        await tester.pumpAndSettle();
        await tester.enterText(find.byType(TextFormField), _mockText);

        await tester.pump(_pumpDuration);
        expect(find.text(_mockText), findsOneWidget);

        await tester.pumpAndSettle(_pumpDuration);
        expect(find.text(_mockText), findsNothing);
      },
    );
  });
}
