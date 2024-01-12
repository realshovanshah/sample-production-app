import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:url_shortener_api/url_shortener_api.dart';

/// {@template url_model}
/// A Url representation for the feature layer.
/// {@endtemplate}
@immutable
class UrlModel {
  /// {@macro url_model}
  const UrlModel({
    required this.original,
    required this.shortened,
  });

  /// Converter from a [ShortenedUrl] to a [UrlModel].
  factory UrlModel.fromEntity(ShortenedUrl shortenedUrl) {
    return UrlModel(
      original: shortenedUrl.link.url,
      shortened: shortenedUrl.link.short,
    );
  }

  /// The original url.
  final String original;

  /// The shortened url.
  final String shortened;

  @override
  String toString() {
    return 'UrlModel(original: $original, shortened: $shortened)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is UrlModel &&
        other.original == original &&
        other.shortened == shortened;
  }

  @override
  int get hashCode => original.hashCode ^ shortened.hashCode;
}
