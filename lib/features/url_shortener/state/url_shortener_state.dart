part of 'url_shortener_cubit.dart';

/// {@template url_shortener_state}
/// Describes the different states of the [UrlShortenerCubit].
/// The [errorMessage] will be null state is not [UrlShortenerState.failure].
/// Instances should be created using the factory methods to
/// make the possible states explicit and typed.
/// {@endtemplate}
@immutable
class UrlShortenerState {
  /// {@macro url_shortener_state}
  const UrlShortenerState._({
    required this.recents,
    required this.status,
    this.errorMessage,
  });

  /// Returns a [UrlShortenerState] with the [status] set to
  /// [UrlShortenerStatus.idle]. Denotes the idle state.
  factory UrlShortenerState.idle({required Stack<UrlModel> recents}) =>
      UrlShortenerState._(
        recents: recents,
        status: UrlShortenerStatus.idle,
      );

  /// Returns a [UrlShortenerState] with the [status] set to
  /// [UrlShortenerStatus.loading] and the [recents] stack.
  factory UrlShortenerState.loading({required Stack<UrlModel> recents}) =>
      UrlShortenerState._(
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
    return UrlShortenerState._(
      recents: recents,
      status: UrlShortenerStatus.success,
    );
  }

  /// Returns a [UrlShortenerState] with the [status] set to
  /// [UrlShortenerStatus.failure] and the [recents] stack.
  factory UrlShortenerState.failure({
    required Stack<UrlModel> recents,
    required String? message,
  }) =>
      UrlShortenerState._(
        recents: recents,
        errorMessage: message,
        status: UrlShortenerStatus.failure,
      );

  /// A [Stack] of recently shortened URLs.
  final Stack<UrlModel> recents;

  /// The current status of the [UrlShortenerState].
  final UrlShortenerStatus status;

  /// The error message if the [status] is [UrlShortenerState.failure].
  final String? errorMessage;

  /// A shorthand to get the recently shortened URL, i.e.
  /// the one on the top of the stack.
  UrlModel get recentUrl => recents.peek;

  /// The toString method.
  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'UrlShortenerState(status: $status, recents: $recents, error: $errorMessage)';
  }

  /// The equality operator.
  @override
  bool operator ==(Object? other) {
    if (identical(this, other)) return true;
    return other is UrlShortenerState &&
        runtimeType == other.runtimeType &&
        status == other.status &&
        recents == other.recents &&
        errorMessage == other.errorMessage;
  }

  /// The hashCode method.
  @override
  int get hashCode => hashValues(status, recents, errorMessage);
}

/// Describes the different statuses of the [UrlShortenerState].
enum UrlShortenerStatus {
  /// The idle state of the [UrlShortenerCubit] or the UI.
  idle,

  /// Represents the state when the [UrlShortenerCubit] is loading.
  loading,

  /// Represents the state when the [UrlShortenerCubit] has loaded
  /// and the operation was successful.
  success,

  /// Represents the state when the [UrlShortenerCubit] has loaded
  /// and the operation was unsuccessful.
  failure
}
