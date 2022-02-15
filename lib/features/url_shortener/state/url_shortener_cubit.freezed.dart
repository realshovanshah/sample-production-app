// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'url_shortener_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$UrlShortenerStateTearOff {
  const _$UrlShortenerStateTearOff();

  _UrlShortenerState _internal(
      {required Stack<UrlModel> recents,
      required UrlShortenerStatus status,
      String? errorMessage}) {
    return _UrlShortenerState(
      recents: recents,
      status: status,
      errorMessage: errorMessage,
    );
  }
}

/// @nodoc
const $UrlShortenerState = _$UrlShortenerStateTearOff();

/// @nodoc
mixin _$UrlShortenerState {
  /// A [Stack] of recently shortened URLs.
  Stack<UrlModel> get recents => throw _privateConstructorUsedError;
  UrlShortenerStatus get status => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UrlShortenerStateCopyWith<UrlShortenerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UrlShortenerStateCopyWith<$Res> {
  factory $UrlShortenerStateCopyWith(
          UrlShortenerState value, $Res Function(UrlShortenerState) then) =
      _$UrlShortenerStateCopyWithImpl<$Res>;
  $Res call(
      {Stack<UrlModel> recents,
      UrlShortenerStatus status,
      String? errorMessage});
}

/// @nodoc
class _$UrlShortenerStateCopyWithImpl<$Res>
    implements $UrlShortenerStateCopyWith<$Res> {
  _$UrlShortenerStateCopyWithImpl(this._value, this._then);

  final UrlShortenerState _value;
  // ignore: unused_field
  final $Res Function(UrlShortenerState) _then;

  @override
  $Res call({
    Object? recents = freezed,
    Object? status = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_value.copyWith(
      recents: recents == freezed
          ? _value.recents
          : recents // ignore: cast_nullable_to_non_nullable
              as Stack<UrlModel>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UrlShortenerStatus,
      errorMessage: errorMessage == freezed
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$UrlShortenerStateCopyWith<$Res>
    implements $UrlShortenerStateCopyWith<$Res> {
  factory _$UrlShortenerStateCopyWith(
          _UrlShortenerState value, $Res Function(_UrlShortenerState) then) =
      __$UrlShortenerStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {Stack<UrlModel> recents,
      UrlShortenerStatus status,
      String? errorMessage});
}

/// @nodoc
class __$UrlShortenerStateCopyWithImpl<$Res>
    extends _$UrlShortenerStateCopyWithImpl<$Res>
    implements _$UrlShortenerStateCopyWith<$Res> {
  __$UrlShortenerStateCopyWithImpl(
      _UrlShortenerState _value, $Res Function(_UrlShortenerState) _then)
      : super(_value, (v) => _then(v as _UrlShortenerState));

  @override
  _UrlShortenerState get _value => super._value as _UrlShortenerState;

  @override
  $Res call({
    Object? recents = freezed,
    Object? status = freezed,
    Object? errorMessage = freezed,
  }) {
    return _then(_UrlShortenerState(
      recents: recents == freezed
          ? _value.recents
          : recents // ignore: cast_nullable_to_non_nullable
              as Stack<UrlModel>,
      status: status == freezed
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UrlShortenerStatus,
      errorMessage: errorMessage == freezed
          ? _value.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_UrlShortenerState extends _UrlShortenerState {
  const _$_UrlShortenerState(
      {required this.recents, required this.status, this.errorMessage})
      : super._();

  @override

  /// A [Stack] of recently shortened URLs.
  final Stack<UrlModel> recents;
  @override
  final UrlShortenerStatus status;
  @override
  final String? errorMessage;

  @override
  String toString() {
    return 'UrlShortenerState._internal(recents: $recents, status: $status, errorMessage: $errorMessage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UrlShortenerState &&
            const DeepCollectionEquality().equals(other.recents, recents) &&
            const DeepCollectionEquality().equals(other.status, status) &&
            const DeepCollectionEquality()
                .equals(other.errorMessage, errorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(recents),
      const DeepCollectionEquality().hash(status),
      const DeepCollectionEquality().hash(errorMessage));

  @JsonKey(ignore: true)
  @override
  _$UrlShortenerStateCopyWith<_UrlShortenerState> get copyWith =>
      __$UrlShortenerStateCopyWithImpl<_UrlShortenerState>(this, _$identity);
}

abstract class _UrlShortenerState extends UrlShortenerState {
  const factory _UrlShortenerState(
      {required Stack<UrlModel> recents,
      required UrlShortenerStatus status,
      String? errorMessage}) = _$_UrlShortenerState;
  const _UrlShortenerState._() : super._();

  @override

  /// A [Stack] of recently shortened URLs.
  Stack<UrlModel> get recents;
  @override
  UrlShortenerStatus get status;
  @override
  String? get errorMessage;
  @override
  @JsonKey(ignore: true)
  _$UrlShortenerStateCopyWith<_UrlShortenerState> get copyWith =>
      throw _privateConstructorUsedError;
}
