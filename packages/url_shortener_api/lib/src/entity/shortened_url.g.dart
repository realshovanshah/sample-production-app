// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shortened_url.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ShortenedUrlAdapter extends TypeAdapter<ShortenedUrl> {
  @override
  final int typeId = 1;

  @override
  ShortenedUrl read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ShortenedUrl(
      aliasId: fields[0] as String,
      link: fields[1] as Links,
    );
  }

  @override
  void write(BinaryWriter writer, ShortenedUrl obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.aliasId)
      ..writeByte(1)
      ..write(obj.link);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ShortenedUrlAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class LinksAdapter extends TypeAdapter<Links> {
  @override
  final int typeId = 0;

  @override
  Links read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Links(
      url: fields[0] as String,
      short: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Links obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.url)
      ..writeByte(1)
      ..write(obj.short);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LinksAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

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
