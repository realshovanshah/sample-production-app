// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'original_url.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OriginalUrl _$OriginalUrlFromJson(Map<String, dynamic> json) {
  return _OriginalUrl.fromJson(json);
}

/// @nodoc
class _$OriginalUrlTearOff {
  const _$OriginalUrlTearOff();

  _OriginalUrl call({required String url}) {
    return _OriginalUrl(
      url: url,
    );
  }

  OriginalUrl fromJson(Map<String, Object?> json) {
    return OriginalUrl.fromJson(json);
  }
}

/// @nodoc
const $OriginalUrl = _$OriginalUrlTearOff();

/// @nodoc
mixin _$OriginalUrl {
  /// Represents the original link, i.e. the full URL.
  String get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OriginalUrlCopyWith<OriginalUrl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OriginalUrlCopyWith<$Res> {
  factory $OriginalUrlCopyWith(
          OriginalUrl value, $Res Function(OriginalUrl) then) =
      _$OriginalUrlCopyWithImpl<$Res>;
  $Res call({String url});
}

/// @nodoc
class _$OriginalUrlCopyWithImpl<$Res> implements $OriginalUrlCopyWith<$Res> {
  _$OriginalUrlCopyWithImpl(this._value, this._then);

  final OriginalUrl _value;
  // ignore: unused_field
  final $Res Function(OriginalUrl) _then;

  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$OriginalUrlCopyWith<$Res>
    implements $OriginalUrlCopyWith<$Res> {
  factory _$OriginalUrlCopyWith(
          _OriginalUrl value, $Res Function(_OriginalUrl) then) =
      __$OriginalUrlCopyWithImpl<$Res>;
  @override
  $Res call({String url});
}

/// @nodoc
class __$OriginalUrlCopyWithImpl<$Res> extends _$OriginalUrlCopyWithImpl<$Res>
    implements _$OriginalUrlCopyWith<$Res> {
  __$OriginalUrlCopyWithImpl(
      _OriginalUrl _value, $Res Function(_OriginalUrl) _then)
      : super(_value, (v) => _then(v as _OriginalUrl));

  @override
  _OriginalUrl get _value => super._value as _OriginalUrl;

  @override
  $Res call({
    Object? url = freezed,
  }) {
    return _then(_OriginalUrl(
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OriginalUrl implements _OriginalUrl {
  const _$_OriginalUrl({required this.url});

  factory _$_OriginalUrl.fromJson(Map<String, dynamic> json) =>
      _$$_OriginalUrlFromJson(json);

  @override

  /// Represents the original link, i.e. the full URL.
  final String url;

  @override
  String toString() {
    return 'OriginalUrl(url: $url)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _OriginalUrl &&
            const DeepCollectionEquality().equals(other.url, url));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(url));

  @JsonKey(ignore: true)
  @override
  _$OriginalUrlCopyWith<_OriginalUrl> get copyWith =>
      __$OriginalUrlCopyWithImpl<_OriginalUrl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OriginalUrlToJson(this);
  }
}

abstract class _OriginalUrl implements OriginalUrl {
  const factory _OriginalUrl({required String url}) = _$_OriginalUrl;

  factory _OriginalUrl.fromJson(Map<String, dynamic> json) =
      _$_OriginalUrl.fromJson;

  @override

  /// Represents the original link, i.e. the full URL.
  String get url;
  @override
  @JsonKey(ignore: true)
  _$OriginalUrlCopyWith<_OriginalUrl> get copyWith =>
      throw _privateConstructorUsedError;
}
