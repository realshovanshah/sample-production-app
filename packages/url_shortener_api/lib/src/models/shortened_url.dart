import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:url_shortener_api/src/types/json_map.dart';

part 'shortened_url.g.dart';
part 'shortened_url.freezed.dart';

/// {@template shortened_url}
/// A model that represents the shortened url data.
/// {@endtemplate}
@freezed
@HiveType(typeId: 1)
class ShortenedUrl with _$ShortenedUrl {
  /// {@macro shortened_url}
  const factory ShortenedUrl({
    /// Alias id of the shortened url.
    @JsonKey(name: 'alias') @HiveField(0) required final String aliasId,

    /// Link data of the shortened url.
    @JsonKey(name: '_links') @HiveField(1) required final Links link,
  }) = _ShortenedUrl;

  /// {@macro json_serializable}
  factory ShortenedUrl.fromJson(JsonMap json) => _$ShortenedUrlFromJson(json);
}

/// {@template links}
/// A link representation that contains both the original and the shortened url.
/// {@endtemplate}
@visibleForTesting
@freezed
@HiveType(typeId: 0)
class Links with _$Links {
  /// {@macro links}
  const factory Links({
    /// The original url.
    @JsonKey(name: 'self') @HiveField(0) required final String url,

    /// The shortened url.
    @HiveField(1) required final String short,
  }) = _Links;

  /// {@macro json_serializable}
  factory Links.fromJson(JsonMap json) => _$LinksFromJson(json);
}
