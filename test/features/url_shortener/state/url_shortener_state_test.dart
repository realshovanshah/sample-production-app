import 'package:equatable_stack/equatable_stack.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:link_shortener/features/url_shortener/state/state.dart';
import 'package:mocktail/mocktail.dart';
import 'package:url_shortener_api/url_shortener_api.dart';

class MockCallback extends Mock {
  void call();
}

void main() {
  group('instantiation', () {
    test('UrlShortenerState.idle', () {
      expect(
        UrlShortenerState.idle(recents: Stack()),
        isA<UrlShortenerState>()
            .having((p1) => p1.recents, 'recents', isEmpty)
            .having((p2) => p2.errorMessage, 'errorMessage', null)
            .having((p3) => p3.status, 'status', UrlShortenerStatus.idle),
      );
    });

    test('UrlShortenerState.loading', () {
      expect(
        UrlShortenerState.loading(recents: Stack<UrlModel>()),
        isA<UrlShortenerState>()
            .having((p1) => p1.recents, 'recents', Stack<UrlModel>())
            .having((p2) => p2.errorMessage, 'errorMessage', null)
            .having((p3) => p3.status, 'status', UrlShortenerStatus.loading),
      );
    });

    test('UrlShortenerState.success', () {
      final _mockRecents = Stack<UrlModel>.of(
        const [
          UrlModel(
            original: 'https://www.test.com',
            shortened: 'https://t.co/1',
          )
        ],
      );
      expect(
        UrlShortenerState.success(recents: _mockRecents),
        isA<UrlShortenerState>()
            .having((p1) => p1.recents, 'recents', _mockRecents)
            .having((p2) => p2.errorMessage, 'errorMessage', null)
            .having((p3) => p3.status, 'status', UrlShortenerStatus.success),
      );
    });

    test('UrlShortenerState.success cant have a empty recents', () {
      final _mockRecents = Stack<UrlModel>.of(const []);
      expect(
        () => UrlShortenerState.success(recents: _mockRecents),
        throwsAssertionError,
      );
    });

    test('UrlShortenerState.failure', () {
      expect(
        UrlShortenerState.failure(recents: Stack<UrlModel>(), message: 'error'),
        isA<UrlShortenerState>()
            .having((p1) => p1.recents, 'recents', Stack<UrlModel>())
            .having((p2) => p2.errorMessage, 'errorMessage', 'error')
            .having((p3) => p3.status, 'status', UrlShortenerStatus.failure),
      );
    });
  });

  test('.whenOrNull', () {
    final _mockRecents = Stack<UrlModel>.of(
      const [
        UrlModel(original: 'https://www.test.com', shortened: 'https://t.co/1')
      ],
    );

    final mockSuccessCallback = MockCallback();
    when(mockSuccessCallback.call).thenReturn(null);
    UrlShortenerState.success(recents: _mockRecents).whenOrNull(
      success: (recents) => mockSuccessCallback.call(),
    );
    verify(mockSuccessCallback.call).called(1);

    final mockLoadingCallback = MockCallback();
    when(mockLoadingCallback.call).thenReturn(null);
    UrlShortenerState.loading(recents: _mockRecents).whenOrNull<void>(
      loading: mockLoadingCallback.call,
    );
    verify(mockLoadingCallback.call).called(1);

    final mockFailureCallback = MockCallback();
    when(mockFailureCallback.call).thenReturn(null);
    UrlShortenerState.failure(recents: _mockRecents, message: '').whenOrNull(
      failure: (message) => mockFailureCallback.call(),
    );
    verify(mockFailureCallback.call).called(1);

    final mockIdleCallback = MockCallback();
    when(mockIdleCallback.call).thenReturn(null);
    UrlShortenerState.idle(recents: _mockRecents).whenOrNull<void>(
      idle: mockIdleCallback.call,
    );
    verify(mockIdleCallback.call).called(1);
  });

  test('support value equality', () {
    final _mockRecents = Stack<UrlModel>.of(
      const [
        UrlModel(
          original: 'https://www.test.com',
          shortened: 'https://te.co/1',
        )
      ],
    );
    final _mockState1 = UrlShortenerState.loading(recents: _mockRecents);
    final _mockState2 = UrlShortenerState.loading(recents: _mockRecents);
    expect(_mockState1, _mockState2);
    expect(_mockState1.hashCode, _mockState2.hashCode);
  });

  test('overrides toString method', () {
    final _mockRecents = Stack<UrlModel>.of(
      const [
        UrlModel(
          original: 'https://www.test.com',
          shortened: 'https://t.co/1',
        )
      ],
    );
    final _mockState = UrlShortenerState.idle(recents: _mockRecents);
    expect(_mockState.toString(), contains('${_mockState.runtimeType}'));
  });
}
