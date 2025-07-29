// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterResponse _$CharacterResponseFromJson(Map<String, dynamic> json) =>
    CharacterResponse(
      info: CharacterInfo.fromJson(json['info'] as Map<String, dynamic>),
      characters: (json['results'] as List<dynamic>)
          .map((e) => Character.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CharacterResponseToJson(CharacterResponse instance) =>
    <String, dynamic>{'info': instance.info, 'results': instance.characters};

Character _$CharacterFromJson(Map<String, dynamic> json) => Character(
  id: (json['id'] as num).toInt(),
  url: json['url'] as String,
  name: json['name'] as String,
  type: json['type'] as String,
  image: json['image'] as String,
  origin: Origin.fromJson(json['origin'] as Map<String, dynamic>),
  gender: json['gender'] as String,
  status: json['status'] as String,
  species: json['species'] as String,
  location: CharacterLocation.fromJson(
    json['location'] as Map<String, dynamic>,
  ),
  episodes: (json['episode'] as List<dynamic>).map((e) => e as String).toList(),
);

Map<String, dynamic> _$CharacterToJson(Character instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'name': instance.name,
  'type': instance.type,
  'image': instance.image,
  'gender': instance.gender,
  'species': instance.species,
  'status': instance.status,
  'origin': instance.origin,
  'location': instance.location,
  'episode': instance.episodes,
};

Origin _$OriginFromJson(Map<String, dynamic> json) =>
    Origin(name: json['name'] as String, url: json['url'] as String);

Map<String, dynamic> _$OriginToJson(Origin instance) => <String, dynamic>{
  'name': instance.name,
  'url': instance.url,
};

CharacterLocation _$CharacterLocationFromJson(Map<String, dynamic> json) =>
    CharacterLocation(name: json['name'] as String, url: json['url'] as String);

Map<String, dynamic> _$CharacterLocationToJson(CharacterLocation instance) =>
    <String, dynamic>{'url': instance.url, 'name': instance.name};

CharacterInfo _$CharacterInfoFromJson(Map<String, dynamic> json) =>
    CharacterInfo(
      count: (json['count'] as num).toInt(),
      pages: (json['pages'] as num).toInt(),
      next: json['next'] as String,
    );

Map<String, dynamic> _$CharacterInfoToJson(CharacterInfo instance) =>
    <String, dynamic>{
      'count': instance.count,
      'pages': instance.pages,
      'next': instance.next,
    };
