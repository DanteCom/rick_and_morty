import 'package:json_annotation/json_annotation.dart';

part 'origin.g.dart';

@JsonSerializable()
class Origin {
  final String name;
  final String url;

  Origin({required this.name, required this.url});

  Map<String, dynamic> toJson() => _$OriginToJson(this);

  factory Origin.fromJson(Map<String, dynamic> json) => _$OriginFromJson(json);
}
