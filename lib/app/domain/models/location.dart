import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final int id;
  final String url;
  final String name;
  final String type;
  final String dimension;

  Location({
    required this.id,
    required this.url,
    required this.name,
    required this.type,
    required this.dimension,
  });

  Map<String, dynamic> toJson() => _$LocationToJson(this);

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
