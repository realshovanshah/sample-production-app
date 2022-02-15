// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shortened_url.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ShortenedUrl _$$_ShortenedUrlFromJson(Map<String, dynamic> json) =>
    _$_ShortenedUrl(
      aliasId: json['alias'] as String,
      link: Links.fromJson(json['_links'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ShortenedUrlToJson(_$_ShortenedUrl instance) =>
    <String, dynamic>{
      'alias': instance.aliasId,
      '_links': instance.link.toJson(),
    };

_$_Links _$$_LinksFromJson(Map<String, dynamic> json) => _$_Links(
      url: json['self'] as String,
      short: json['short'] as String,
    );

Map<String, dynamic> _$$_LinksToJson(_$_Links instance) => <String, dynamic>{
      'self': instance.url,
      'short': instance.short,
    };
