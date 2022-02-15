part of 'url_shortener_cubit.dart';

/// {@template url_shortener_state}
/// Describes the different states of the [UrlShortenerCubit].
/// {@endtemplate}
@freezed
class UrlShortenerState with _$UrlShortenerState {
  /// {@macro url_shortener_state}
  const factory UrlShortenerState._internal({
    /// A [Stack] of recently shortened URLs.
    required final Stack<UrlModel> recents,
    required final UrlShortenerStatus status,
    final String? errorMessage,
  }) = _UrlShortenerState;

  const UrlShortenerState._();

  /// Returns a [UrlShortenerState] with the [status] set to
  /// [UrlShortenerStatus.idle]. Denotes the idle state.
  factory UrlShortenerState.idle({Stack<UrlModel>? recents}) =>
      UrlShortenerState._internal(
        recents: recents ?? Stack(),
        status: UrlShortenerStatus.idle,
      );

  /// Returns a [UrlShortenerState] with the [status] set to
  /// [UrlShortenerStatus.loading] and the [recents] stack.
  factory UrlShortenerState.loading({required Stack<UrlModel> recents}) =>
      UrlShortenerState._internal(
        recents: recents,
        status: UrlShortenerStatus.loading,
      );

  /// Returns a [UrlShortenerState] with the [status] set to
  /// [UrlShortenerStatus.success] and the [recents] stack.
  /// The [recents] should not be empty when the status is success.
  factory UrlShortenerState.success({required Stack<UrlModel> recents}) {
    assert(
      recents.isNotEmpty,
      'The recents stack should not be empty when successful.',
    );
    return UrlShortenerState._internal(
      recents: recents,
      status: UrlShortenerStatus.success,
    );
  }

  /// Returns a [UrlShortenerState] with the [status] set to
  /// [UrlShortenerStatus.failure] and the [recents] stack.
  factory UrlShortenerState.failure({
    required Stack<UrlModel> recents,
    required String message,
  }) =>
      UrlShortenerState._internal(
        recents: recents,
        errorMessage: message,
        status: UrlShortenerStatus.failure,
      );

  /// A shorthand to get the recently shortened URL, i.e.
  /// the one on the top of the stack.
  UrlModel get recentUrl => recents.peek;
}

/// Describes the different statuses of the [UrlShortenerState].
enum UrlShortenerStatus {
  /// The idle state of the [UrlShortenerCubit] or the UI.
  idle,

  /// Respresents the state when the [UrlShortenerCubit] is loading.
  loading,

  /// Respresents the state when the [UrlShortenerCubit] has loaded
  /// and the operation was successful.
  success,

  /// Respresents the state when the [UrlShortenerCubit] has loaded
  /// and the operation was unsuccessful.
  failure
}
