// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tv.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tv _$TvFromJson(Map<String, dynamic> json) => Tv(
      json['name'] as String,
      (json['source'] as List<dynamic>).map((e) => e as String).toList(),
      json['sourceId'] as int? ?? 0,
      json['star'] as bool? ?? false,
    )..image = json['image'] as String?;

Map<String, dynamic> _$TvToJson(Tv instance) => <String, dynamic>{
      'name': instance.name,
      'star': instance.star,
      'image': instance.image,
      'source': instance.source,
      'sourceId': instance.sourceId,
    };
