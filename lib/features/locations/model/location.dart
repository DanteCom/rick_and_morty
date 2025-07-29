import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class LocationResponse {
  final LocationInfo info;
  @JsonKey(name: 'results')
  final List<Location> locations;

  LocationResponse({required this.info, required this.locations});

  Map<String, dynamic> toJson() => _$LocationResponseToJson(this);

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseFromJson(json);
}

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

@JsonSerializable()
class LocationInfo {
  final int count;
  final int pages;
  final String next;

  LocationInfo({required this.count, required this.pages, required this.next});

  Map<String, dynamic> toJson() => _$LocationInfoToJson(this);

  factory LocationInfo.fromJson(Map<String, dynamic> json) =>
      _$LocationInfoFromJson(json);
}
