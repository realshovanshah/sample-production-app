import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_shortener_api/url_shortener_api.dart';

part 'url_model.freezed.dart';
part 'url_model.g.dart';

/// {@template url_model}
/// A Url representation for the feature layer.
/// {@endtemplate}
@freezed
class UrlModel with _$UrlModel {
  /// {@macro url_model}
  const factory UrlModel({
    required final String original,
    required final String shortened,
  }) = _UrlModel;

  /// {@template from_json}
  /// Json Serialization for the [UrlModel].
  /// {@endtemplate}
  factory UrlModel.fromJson(Map<String, dynamic> json) =>
      _$UrlModelFromJson(json);

  /// Converter from a [ShortenedUrl] to a [UrlModel].
  factory UrlModel.fromEntity(ShortenedUrl shortenedUrl) {
    return UrlModel(
      original: shortenedUrl.link.url,
      shortened: shortenedUrl.link.short,
    );
  }
}
