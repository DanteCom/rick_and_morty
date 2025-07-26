// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

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

CharacterLocation _$CharacterLocationFromJson(Map<String, dynamic> json) =>
    CharacterLocation(name: json['name'] as String, url: json['url'] as String);

Map<String, dynamic> _$CharacterLocationToJson(CharacterLocation instance) =>
    <String, dynamic>{'name': instance.name, 'url': instance.url};
