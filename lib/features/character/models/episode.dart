import 'package:json_annotation/json_annotation.dart';

part 'episode.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class Episode {
  final int id;
  final String url;
  final String name;
  final String airDate;
  final String episode;
  final List<String> characters;

  Episode({
    required this.id,
    required this.url,
    required this.name,
    required this.airDate,
    required this.episode,
    required this.characters,
  });

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
}
