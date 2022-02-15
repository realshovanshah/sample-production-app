// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'shortened_url.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ShortenedUrl _$ShortenedUrlFromJson(Map<String, dynamic> json) {
  return _ShortenedUrl.fromJson(json);
}

/// @nodoc
class _$ShortenedUrlTearOff {
  const _$ShortenedUrlTearOff();

  _ShortenedUrl call(
      {@JsonKey(name: 'alias') required String aliasId,
      @JsonKey(name: '_links') required Links link}) {
    return _ShortenedUrl(
      aliasId: aliasId,
      link: link,
    );
  }

  ShortenedUrl fromJson(Map<String, Object?> json) {
    return ShortenedUrl.fromJson(json);
  }
}

/// @nodoc
const $ShortenedUrl = _$ShortenedUrlTearOff();

/// @nodoc
mixin _$ShortenedUrl {
  /// Alias id of the shortened url.
  @JsonKey(name: 'alias')
  String get aliasId => throw _privateConstructorUsedError;

  /// Link data of the shortened url.
  @JsonKey(name: '_links')
  Links get link => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShortenedUrlCopyWith<ShortenedUrl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShortenedUrlCopyWith<$Res> {
  factory $ShortenedUrlCopyWith(
          ShortenedUrl value, $Res Function(ShortenedUrl) then) =
      _$ShortenedUrlCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'alias') String aliasId,
      @JsonKey(name: '_links') Links link});

  $LinksCopyWith<$Res> get link;
}

/// @nodoc
class _$ShortenedUrlCopyWithImpl<$Res> implements $ShortenedUrlCopyWith<$Res> {
  _$ShortenedUrlCopyWithImpl(this._value, this._then);

  final ShortenedUrl _value;
  // ignore: unused_field
  final $Res Function(ShortenedUrl) _then;

  @override
  $Res call({
    Object? aliasId = freezed,
    Object? link = freezed,
  }) {
    return _then(_value.copyWith(
      aliasId: aliasId == freezed
          ? _value.aliasId
          : aliasId // ignore: cast_nullable_to_non_nullable
              as String,
      link: link == freezed
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as Links,
    ));
  }

  @override
  $LinksCopyWith<$Res> get link {
    return $LinksCopyWith<$Res>(_value.link, (value) {
      return _then(_value.copyWith(link: value));
    });
  }
}

/// @nodoc
abstract class _$ShortenedUrlCopyWith<$Res>
    implements $ShortenedUrlCopyWith<$Res> {
  factory _$ShortenedUrlCopyWith(
          _ShortenedUrl value, $Res Function(_ShortenedUrl) then) =
      __$ShortenedUrlCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'alias') String aliasId,
      @JsonKey(name: '_links') Links link});

  @override
  $LinksCopyWith<$Res> get link;
}

/// @nodoc
class __$ShortenedUrlCopyWithImpl<$Res> extends _$ShortenedUrlCopyWithImpl<$Res>
    implements _$ShortenedUrlCopyWith<$Res> {
  __$ShortenedUrlCopyWithImpl(
      _ShortenedUrl _value, $Res Function(_ShortenedUrl) _then)
      : super(_value, (v) => _then(v as _ShortenedUrl));

  @override
  _ShortenedUrl get _value => super._value as _ShortenedUrl;

  @override
  $Res call({
    Object? aliasId = freezed,
    Object? link = freezed,
  }) {
    return _then(_ShortenedUrl(
      aliasId: aliasId == freezed
          ? _value.aliasId
          : aliasId // ignore: cast_nullable_to_non_nullable
              as String,
      link: link == freezed
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as Links,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ShortenedUrl implements _ShortenedUrl {
  const _$_ShortenedUrl(
      {@JsonKey(name: 'alias') required this.aliasId,
      @JsonKey(name: '_links') required this.link});

  factory _$_ShortenedUrl.fromJson(Map<String, dynamic> json) =>
      _$$_ShortenedUrlFromJson(json);

  @override

  /// Alias id of the shortened url.
  @JsonKey(name: 'alias')
  final String aliasId;
  @override

  /// Link data of the shortened url.
  @JsonKey(name: '_links')
  final Links link;

  @override
  String toString() {
    return 'ShortenedUrl(aliasId: $aliasId, link: $link)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ShortenedUrl &&
            const DeepCollectionEquality().equals(other.aliasId, aliasId) &&
            const DeepCollectionEquality().equals(other.link, link));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(aliasId),
      const DeepCollectionEquality().hash(link));

  @JsonKey(ignore: true)
  @override
  _$ShortenedUrlCopyWith<_ShortenedUrl> get copyWith =>
      __$ShortenedUrlCopyWithImpl<_ShortenedUrl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ShortenedUrlToJson(this);
  }
}

abstract class _ShortenedUrl implements ShortenedUrl {
  const factory _ShortenedUrl(
      {@JsonKey(name: 'alias') required String aliasId,
      @JsonKey(name: '_links') required Links link}) = _$_ShortenedUrl;

  factory _ShortenedUrl.fromJson(Map<String, dynamic> json) =
      _$_ShortenedUrl.fromJson;

  @override

  /// Alias id of the shortened url.
  @JsonKey(name: 'alias')
  String get aliasId;
  @override

  /// Link data of the shortened url.
  @JsonKey(name: '_links')
  Links get link;
  @override
  @JsonKey(ignore: true)
  _$ShortenedUrlCopyWith<_ShortenedUrl> get copyWith =>
      throw _privateConstructorUsedError;
}

Links _$LinksFromJson(Map<String, dynamic> json) {
  return _Links.fromJson(json);
}

/// @nodoc
class _$LinksTearOff {
  const _$LinksTearOff();

  _Links call(
      {@JsonKey(name: 'self') required String url, required String short}) {
    return _Links(
      url: url,
      short: short,
    );
  }

  Links fromJson(Map<String, Object?> json) {
    return Links.fromJson(json);
  }
}

/// @nodoc
const $Links = _$LinksTearOff();

/// @nodoc
mixin _$Links {
  /// The original url.
  @JsonKey(name: 'self')
  String get url => throw _privateConstructorUsedError;

  /// The shortened url.
  String get short => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LinksCopyWith<Links> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinksCopyWith<$Res> {
  factory $LinksCopyWith(Links value, $Res Function(Links) then) =
      _$LinksCopyWithImpl<$Res>;
  $Res call({@JsonKey(name: 'self') String url, String short});
}

/// @nodoc
class _$LinksCopyWithImpl<$Res> implements $LinksCopyWith<$Res> {
  _$LinksCopyWithImpl(this._value, this._then);

  final Links _value;
  // ignore: unused_field
  final $Res Function(Links) _then;

  @override
  $Res call({
    Object? url = freezed,
    Object? short = freezed,
  }) {
    return _then(_value.copyWith(
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      short: short == freezed
          ? _value.short
          : short // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$LinksCopyWith<$Res> implements $LinksCopyWith<$Res> {
  factory _$LinksCopyWith(_Links value, $Res Function(_Links) then) =
      __$LinksCopyWithImpl<$Res>;
  @override
  $Res call({@JsonKey(name: 'self') String url, String short});
}

/// @nodoc
class __$LinksCopyWithImpl<$Res> extends _$LinksCopyWithImpl<$Res>
    implements _$LinksCopyWith<$Res> {
  __$LinksCopyWithImpl(_Links _value, $Res Function(_Links) _then)
      : super(_value, (v) => _then(v as _Links));

  @override
  _Links get _value => super._value as _Links;

  @override
  $Res call({
    Object? url = freezed,
    Object? short = freezed,
  }) {
    return _then(_Links(
      url: url == freezed
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      short: short == freezed
          ? _value.short
          : short // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Links implements _Links {
  const _$_Links(
      {@JsonKey(name: 'self') required this.url, required this.short});

  factory _$_Links.fromJson(Map<String, dynamic> json) =>
      _$$_LinksFromJson(json);

  @override

  /// The original url.
  @JsonKey(name: 'self')
  final String url;
  @override

  /// The shortened url.
  final String short;

  @override
  String toString() {
    return 'Links(url: $url, short: $short)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Links &&
            const DeepCollectionEquality().equals(other.url, url) &&
            const DeepCollectionEquality().equals(other.short, short));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(url),
      const DeepCollectionEquality().hash(short));

  @JsonKey(ignore: true)
  @override
  _$LinksCopyWith<_Links> get copyWith =>
      __$LinksCopyWithImpl<_Links>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LinksToJson(this);
  }
}

abstract class _Links implements Links {
  const factory _Links(
      {@JsonKey(name: 'self') required String url,
      required String short}) = _$_Links;

  factory _Links.fromJson(Map<String, dynamic> json) = _$_Links.fromJson;

  @override

  /// The original url.
  @JsonKey(name: 'self')
  String get url;
  @override

  /// The shortened url.
  String get short;
  @override
  @JsonKey(ignore: true)
  _$LinksCopyWith<_Links> get copyWith => throw _privateConstructorUsedError;
}
