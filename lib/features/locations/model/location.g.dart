// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationResponse _$LocationResponseFromJson(Map<String, dynamic> json) =>
    LocationResponse(
      info: LocationInfo.fromJson(json['info'] as Map<String, dynamic>),
      locations: (json['results'] as List<dynamic>)
          .map((e) => Location.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LocationResponseToJson(LocationResponse instance) =>
    <String, dynamic>{'info': instance.info, 'results': instance.locations};

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
  id: (json['id'] as num).toInt(),
  url: json['url'] as String,
  name: json['name'] as String,
  type: json['type'] as String,
  dimension: json['dimension'] as String,
);

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'name': instance.name,
  'type': instance.type,
  'dimension': instance.dimension,
};

LocationInfo _$LocationInfoFromJson(Map<String, dynamic> json) => LocationInfo(
  count: (json['count'] as num).toInt(),
  pages: (json['pages'] as num).toInt(),
  next: json['next'] as String,
);

Map<String, dynamic> _$LocationInfoToJson(LocationInfo instance) =>
    <String, dynamic>{
      'count': instance.count,
      'pages': instance.pages,
      'next': instance.next,
    };
