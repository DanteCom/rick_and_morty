import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/core.dart';
import 'package:rick_and_morty/features/locations/model/location.dart';

class LocationService {
  final _dio = ApiClient();

  Future<LocationResponse> getAllLocations() async {
    final url = "https://rickandmortyapi.com/api/location";

    try {
      final response = await _dio.get(url);
      final data = response.data;

      if (data is! Map<String, dynamic>) {
        throw Exception('Неверный формат данных от API');
      }

      return LocationResponse.fromJson(data);
    } on ApiException catch (_) {
      rethrow;
    } catch (e, s) {
      debugPrint('Error in $runtimeType.getAllLocations: $e\n$s');
      throw Exception('Ошибка при получении локации.');
    }
  }

  Future<List<Location>> searchLocations(String name) async {
    try {
      final response = await _dio.get(
        'location/',
        queryParameters: {'name': name},
      );

      final data = response.data;

      if (data is! Map<String, dynamic> || data['results'] is! List) {
        throw ApiException(message: 'Неверный формат данных от API');
      }

      final results = data['results'] as List;

      return results.map((json) => Location.fromJson(json)).toList();
    } on ApiException catch (e) {
      final statusCode = e.statusCode;

      if (statusCode == 404) {
        throw ApiException(
          message: 'Локация не найдена.',
          statusCode: statusCode,
        );
      }

      rethrow;
    } catch (e, s) {
      debugPrint('Error in $runtimeType.searchLocations: $e\n$s');
      throw ApiException(message: 'Ошибка при поиске локации.');
    }
  }
}
