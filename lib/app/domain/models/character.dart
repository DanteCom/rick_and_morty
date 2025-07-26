import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/app/domain/models/models.dart';

part 'character.g.dart';

@JsonSerializable()
class Character {
  final int id;
  final String url;
  final String name;
  final String type;
  final String image;
  final String gender;
  final String species;
  final String status;
  final Origin origin;
  final CharacterLocation location;
  @JsonKey(name: 'episode')
  final List<String> episodes;

  Character({
    required this.id,
    required this.url,
    required this.name,
    required this.type,
    required this.image,
    required this.origin,
    required this.gender,
    required this.status,
    required this.species,
    required this.location,
    required this.episodes,
  });

  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);
}

@JsonSerializable()
class CharacterLocation {
  final String name;
  final String url;

  CharacterLocation({required this.name, required this.url});

  Map<String, dynamic> toJson() => _$CharacterLocationToJson(this);

  factory CharacterLocation.fromJson(Map<String, dynamic> json) =>
      _$CharacterLocationFromJson(json);
}
