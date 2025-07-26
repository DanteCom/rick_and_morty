import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/app/domain/models/models.dart';

class LocationService {
  final _dio = Dio();

  Future<List<Location>> getAllLocations() async {
    final url = "https://rickandmortyapi.com/api/location";

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;
        print(data);

        if (data is! Map || data['results'] is! List) {
          throw Exception('Неверный формат данных от API');
        }

        final results = data['results'] as List;
        return results.map((json) => Location.fromJson(json)).toList();
      } else {
        throw Exception('Ошибка от сервера: ${response.statusCode}');
      }
    } catch (e, s) {
      debugPrint('Error in $runtimeType.getAllLocations: $e\n$s');
      throw Exception('Упс... что-то пошло не так');
    }
  }
}
