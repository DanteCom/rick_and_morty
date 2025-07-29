// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';

part 'character.g.dart';

@JsonSerializable()
class CharacterResponse {
  final CharacterInfo info;
  @JsonKey(name: 'results')
  final List<Character> characters;

  CharacterResponse({required this.info, required this.characters});

  Map<String, dynamic> toJson() => _$CharacterResponseToJson(this);

  factory CharacterResponse.fromJson(Map<String, dynamic> json) =>
      _$CharacterResponseFromJson(json);
}

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
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool isFavorite;
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
    this.isFavorite = false,
  });

  Map<String, dynamic> toJson() => _$CharacterToJson(this);

  factory Character.fromJson(Map<String, dynamic> json) =>
      _$CharacterFromJson(json);

  Character copyWith({
    int? id,
    String? url,
    String? name,
    String? type,
    String? image,
    String? gender,
    String? species,
    String? status,
    Origin? origin,
    bool? isFavorite,
    CharacterLocation? location,
    List<String>? episodes,
  }) {
    return Character(
      id: id ?? this.id,
      url: url ?? this.url,
      name: name ?? this.name,
      type: type ?? this.type,
      image: image ?? this.image,
      gender: gender ?? this.gender,
      species: species ?? this.species,
      status: status ?? this.status,
      origin: origin ?? this.origin,
      isFavorite: isFavorite ?? this.isFavorite,
      location: location ?? this.location,
      episodes: episodes ?? this.episodes,
    );
  }
}

@JsonSerializable()
class Origin {
  final String name;
  final String url;

  Origin({required this.name, required this.url});

  Map<String, dynamic> toJson() => _$OriginToJson(this);

  factory Origin.fromJson(Map<String, dynamic> json) => _$OriginFromJson(json);
}

@JsonSerializable()
class CharacterLocation {
  final String url;
  final String name;

  CharacterLocation({required this.name, required this.url});

  Map<String, dynamic> toJson() => _$CharacterLocationToJson(this);

  factory CharacterLocation.fromJson(Map<String, dynamic> json) =>
      _$CharacterLocationFromJson(json);
}

@JsonSerializable()
class CharacterInfo {
  final int count;
  final int pages;
  final String next;

  CharacterInfo({required this.count, required this.pages, required this.next});

  Map<String, dynamic> toJson() => _$CharacterInfoToJson(this);

  factory CharacterInfo.fromJson(Map<String, dynamic> json) =>
      _$CharacterInfoFromJson(json);
}
