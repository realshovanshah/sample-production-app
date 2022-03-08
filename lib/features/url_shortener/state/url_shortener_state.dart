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
  String? get recentUrl {
    if (recents.isNotEmpty) return recents.peek.shortened;
    return null;
  }

  // todo: add unit tests
  /// Emulating pattern matching for making exclusive states clear.
  /// Return a null value as the fallback.
  T? whenOrNull<T>({
    T Function()? idle,
    T Function()? loading,
    T Function(String shortenedUrl)? success,
    T Function(String message)? failure,
  }) {
    switch (status) {
      case UrlShortenerStatus.idle:
        return idle?.call();
      case UrlShortenerStatus.loading:
        return loading?.call();
      case UrlShortenerStatus.success:
        return success?.call(recentUrl!);
      case UrlShortenerStatus.failure:
        return failure?.call(errorMessage!);
    }
  }

  /// The copyWith method.
  ///
  /// Note: Should be used with caution as it might result in
  /// undefined states. Prefer the named constructors in most cases.
  UrlShortenerState copyWith({
    Stack<UrlModel>? recents,
    UrlShortenerStatus? status,
    String? errorMessage,
  }) =>
      UrlShortenerState._(
        recents: recents ?? this.recents,
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
      );

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
  int get hashCode =>
      recents.hashCode ^ status.hashCode ^ errorMessage.hashCode;
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
