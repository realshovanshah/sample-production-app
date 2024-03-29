// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ResultTearOff {
  const _$ResultTearOff();

  _Success<F, S> success<F, S>(S val) {
    return _Success<F, S>(
      val,
    );
  }

  _Failure<F, S> failure<F, S>(F val) {
    return _Failure<F, S>(
      val,
    );
  }
}

/// @nodoc
const $Result = _$ResultTearOff();

/// @nodoc
mixin _$Result<F, S> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(S val) success,
    required TResult Function(F val) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(S val)? success,
    TResult Function(F val)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(S val)? success,
    TResult Function(F val)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<F, S> value) success,
    required TResult Function(_Failure<F, S> value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Success<F, S> value)? success,
    TResult Function(_Failure<F, S> value)? failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<F, S> value)? success,
    TResult Function(_Failure<F, S> value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ResultCopyWith<F, S, $Res> {
  factory $ResultCopyWith(
          Result<F, S> value, $Res Function(Result<F, S>) then) =
      _$ResultCopyWithImpl<F, S, $Res>;
}

/// @nodoc
class _$ResultCopyWithImpl<F, S, $Res> implements $ResultCopyWith<F, S, $Res> {
  _$ResultCopyWithImpl(this._value, this._then);

  final Result<F, S> _value;
  // ignore: unused_field
  final $Res Function(Result<F, S>) _then;
}

/// @nodoc
abstract class _$SuccessCopyWith<F, S, $Res> {
  factory _$SuccessCopyWith(
          _Success<F, S> value, $Res Function(_Success<F, S>) then) =
      __$SuccessCopyWithImpl<F, S, $Res>;
  $Res call({S val});
}

/// @nodoc
class __$SuccessCopyWithImpl<F, S, $Res>
    extends _$ResultCopyWithImpl<F, S, $Res>
    implements _$SuccessCopyWith<F, S, $Res> {
  __$SuccessCopyWithImpl(
      _Success<F, S> _value, $Res Function(_Success<F, S>) _then)
      : super(_value, (v) => _then(v as _Success<F, S>));

  @override
  _Success<F, S> get _value => super._value as _Success<F, S>;

  @override
  $Res call({
    Object? val = freezed,
  }) {
    return _then(_Success<F, S>(
      val == freezed
          ? _value.val
          : val // ignore: cast_nullable_to_non_nullable
              as S,
    ));
  }
}

/// @nodoc

class _$_Success<F, S> implements _Success<F, S> {
  const _$_Success(this.val);

  @override
  final S val;

  @override
  String toString() {
    return 'Result<$F, $S>.success(val: $val)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Success<F, S> &&
            const DeepCollectionEquality().equals(other.val, val));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(val));

  @JsonKey(ignore: true)
  @override
  _$SuccessCopyWith<F, S, _Success<F, S>> get copyWith =>
      __$SuccessCopyWithImpl<F, S, _Success<F, S>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(S val) success,
    required TResult Function(F val) failure,
  }) {
    return success(val);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(S val)? success,
    TResult Function(F val)? failure,
  }) {
    return success?.call(val);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(S val)? success,
    TResult Function(F val)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(val);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<F, S> value) success,
    required TResult Function(_Failure<F, S> value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Success<F, S> value)? success,
    TResult Function(_Failure<F, S> value)? failure,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<F, S> value)? success,
    TResult Function(_Failure<F, S> value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success<F, S> implements Result<F, S> {
  const factory _Success(S val) = _$_Success<F, S>;

  S get val;
  @JsonKey(ignore: true)
  _$SuccessCopyWith<F, S, _Success<F, S>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$FailureCopyWith<F, S, $Res> {
  factory _$FailureCopyWith(
          _Failure<F, S> value, $Res Function(_Failure<F, S>) then) =
      __$FailureCopyWithImpl<F, S, $Res>;
  $Res call({F val});
}

/// @nodoc
class __$FailureCopyWithImpl<F, S, $Res>
    extends _$ResultCopyWithImpl<F, S, $Res>
    implements _$FailureCopyWith<F, S, $Res> {
  __$FailureCopyWithImpl(
      _Failure<F, S> _value, $Res Function(_Failure<F, S>) _then)
      : super(_value, (v) => _then(v as _Failure<F, S>));

  @override
  _Failure<F, S> get _value => super._value as _Failure<F, S>;

  @override
  $Res call({
    Object? val = freezed,
  }) {
    return _then(_Failure<F, S>(
      val == freezed
          ? _value.val
          : val // ignore: cast_nullable_to_non_nullable
              as F,
    ));
  }
}

/// @nodoc

class _$_Failure<F, S> implements _Failure<F, S> {
  const _$_Failure(this.val);

  @override
  final F val;

  @override
  String toString() {
    return 'Result<$F, $S>.failure(val: $val)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Failure<F, S> &&
            const DeepCollectionEquality().equals(other.val, val));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(val));

  @JsonKey(ignore: true)
  @override
  _$FailureCopyWith<F, S, _Failure<F, S>> get copyWith =>
      __$FailureCopyWithImpl<F, S, _Failure<F, S>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(S val) success,
    required TResult Function(F val) failure,
  }) {
    return failure(val);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(S val)? success,
    TResult Function(F val)? failure,
  }) {
    return failure?.call(val);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(S val)? success,
    TResult Function(F val)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(val);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<F, S> value) success,
    required TResult Function(_Failure<F, S> value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Success<F, S> value)? success,
    TResult Function(_Failure<F, S> value)? failure,
  }) {
    return failure?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<F, S> value)? success,
    TResult Function(_Failure<F, S> value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class _Failure<F, S> implements Result<F, S> {
  const factory _Failure(F val) = _$_Failure<F, S>;

  F get val;
  @JsonKey(ignore: true)
  _$FailureCopyWith<F, S, _Failure<F, S>> get copyWith =>
      throw _privateConstructorUsedError;
}
