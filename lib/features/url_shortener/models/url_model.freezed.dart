// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'url_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UrlModel _$UrlModelFromJson(Map<String, dynamic> json) {
  return _UrlModel.fromJson(json);
}

/// @nodoc
class _$UrlModelTearOff {
  const _$UrlModelTearOff();

  _UrlModel call({required String original, required String shortened}) {
    return _UrlModel(
      original: original,
      shortened: shortened,
    );
  }

  UrlModel fromJson(Map<String, Object?> json) {
    return UrlModel.fromJson(json);
  }
}

/// @nodoc
const $UrlModel = _$UrlModelTearOff();

/// @nodoc
mixin _$UrlModel {
  String get original => throw _privateConstructorUsedError;
  String get shortened => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UrlModelCopyWith<UrlModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UrlModelCopyWith<$Res> {
  factory $UrlModelCopyWith(UrlModel value, $Res Function(UrlModel) then) =
      _$UrlModelCopyWithImpl<$Res>;
  $Res call({String original, String shortened});
}

/// @nodoc
class _$UrlModelCopyWithImpl<$Res> implements $UrlModelCopyWith<$Res> {
  _$UrlModelCopyWithImpl(this._value, this._then);

  final UrlModel _value;
  // ignore: unused_field
  final $Res Function(UrlModel) _then;

  @override
  $Res call({
    Object? original = freezed,
    Object? shortened = freezed,
  }) {
    return _then(_value.copyWith(
      original: original == freezed
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as String,
      shortened: shortened == freezed
          ? _value.shortened
          : shortened // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$UrlModelCopyWith<$Res> implements $UrlModelCopyWith<$Res> {
  factory _$UrlModelCopyWith(_UrlModel value, $Res Function(_UrlModel) then) =
      __$UrlModelCopyWithImpl<$Res>;
  @override
  $Res call({String original, String shortened});
}

/// @nodoc
class __$UrlModelCopyWithImpl<$Res> extends _$UrlModelCopyWithImpl<$Res>
    implements _$UrlModelCopyWith<$Res> {
  __$UrlModelCopyWithImpl(_UrlModel _value, $Res Function(_UrlModel) _then)
      : super(_value, (v) => _then(v as _UrlModel));

  @override
  _UrlModel get _value => super._value as _UrlModel;

  @override
  $Res call({
    Object? original = freezed,
    Object? shortened = freezed,
  }) {
    return _then(_UrlModel(
      original: original == freezed
          ? _value.original
          : original // ignore: cast_nullable_to_non_nullable
              as String,
      shortened: shortened == freezed
          ? _value.shortened
          : shortened // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UrlModel implements _UrlModel {
  const _$_UrlModel({required this.original, required this.shortened});

  factory _$_UrlModel.fromJson(Map<String, dynamic> json) =>
      _$$_UrlModelFromJson(json);

  @override
  final String original;
  @override
  final String shortened;

  @override
  String toString() {
    return 'UrlModel(original: $original, shortened: $shortened)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UrlModel &&
            const DeepCollectionEquality().equals(other.original, original) &&
            const DeepCollectionEquality().equals(other.shortened, shortened));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(original),
      const DeepCollectionEquality().hash(shortened));

  @JsonKey(ignore: true)
  @override
  _$UrlModelCopyWith<_UrlModel> get copyWith =>
      __$UrlModelCopyWithImpl<_UrlModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UrlModelToJson(this);
  }
}

abstract class _UrlModel implements UrlModel {
  const factory _UrlModel(
      {required String original, required String shortened}) = _$_UrlModel;

  factory _UrlModel.fromJson(Map<String, dynamic> json) = _$_UrlModel.fromJson;

  @override
  String get original;
  @override
  String get shortened;
  @override
  @JsonKey(ignore: true)
  _$UrlModelCopyWith<_UrlModel> get copyWith =>
      throw _privateConstructorUsedError;
}
