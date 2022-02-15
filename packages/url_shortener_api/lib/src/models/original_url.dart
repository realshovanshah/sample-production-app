import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_shortener_api/src/types/json_map.dart';

part 'original_url.g.dart';
part 'original_url.freezed.dart';

/// {@template original_url}
/// A model that represents the original url data.
/// {@endtemplate}
@freezed
class OriginalUrl with _$OriginalUrl {
  /// {@macro original_url}
  const factory OriginalUrl({
    /// Represents the original link, i.e. the full URL.
    required final String url,
  }) = _OriginalUrl;

  /// {@template json_serializable}
  /// A de-serialization method that converts JSON [Map] into a class instance.
  /// Also generates a serialization method that returns a [JsonMap].
  /// {@endtemplate}
  factory OriginalUrl.fromJson(JsonMap json) => _$OriginalUrlFromJson(json);
}
