import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty/core/core.dart';
import 'package:rick_and_morty/features/character/models/episode.dart';
import 'package:rick_and_morty/features/character/models/character.dart';

class CharacterService {
  final _dio = ApiClient();
  final _box = Hive.box('characters');

  CharacterService._instances();
  factory CharacterService() => _instance;
  static final CharacterService _instance = CharacterService._instances();

  final _controller = StreamController<List<int>>.broadcast();

  static Future<void> initialize() async => await _instance._initialize();
  Stream<List<int>> get streamFavorites => _instance._controller.stream;

  Future<CharacterResponse> getAllCharacters({int page = 1}) async {
    try {
      final response = await _dio.get('character/');

      final data = response.data;

      if (data is! Map<String, dynamic>) {
        throw ApiException(message: 'Неверный формат данных от API');
      }

      return CharacterResponse.fromJson(data);
    } on ApiException catch (_) {
      rethrow;
    } catch (e, s) {
      debugPrint('Error in $runtimeType.getAllCharacters: $e\n$s');
      throw ApiException(message: 'Ошибка при получении персонажей.');
    }
  }

  Future<Character> getCharacter(int id) async {
    try {
      final response = await _dio.get('character/$id');

      final data = response.data;
      if (data is! Map<String, dynamic>) {
        throw Exception('Неверный формат данных от API');
      }

      return Character.fromJson(data);
    } on ApiException catch (e) {
      final statusCode = e.statusCode;

      if (statusCode == 404) {
        throw ApiException(
          message: 'Персонаж с таким $id не существует',
          statusCode: statusCode,
        );
      }
      rethrow;
    } catch (e, s) {
      debugPrint('Error in $runtimeType.getCharacter: $e\n$s');
      throw ApiException(message: 'Ошибка при получении персонажa.');
    }
  }

  Future<List<Episode>> getEpisodes(List<String> urls) async {
    try {
      final responses = await Future.wait(
        urls.map((u) {
          final url = u.replaceFirst(_dio.baseUrl, '');

          return _dio.get(url);
        }),
      );

      return responses.map((response) {
        final data = response.data;

        if (data is! Map<String, dynamic>) {
          throw ApiException(message: 'Неверный формат данных от API');
        }

        return Episode.fromJson(data);
      }).toList();
    } on ApiException catch (_) {
      rethrow;
    } catch (e, s) {
      debugPrint('Error in $runtimeType.getEpisodes: $e\n$s');
      throw ApiException(message: 'Ошибка при получении эпизодов.');
    }
  }

  Future<List<Character>> searchCharacters(String name) async {
    try {
      final queryParameters = {'name': name.trim()};

      final response = await _dio.get(
        'character/',
        queryParameters: name.isEmpty ? null : queryParameters,
      );

      final data = response.data;

      if (data is! Map<String, dynamic> || data['results'] is! List) {
        throw ApiException(message: 'Неверный формат данных от API');
      }

      final results = data['results'] as List;

      return results.map((json) => Character.fromJson(json)).toList();
    } on ApiException catch (e) {
      final statusCode = e.statusCode;

      if (statusCode != 404) rethrow;

      throw ApiException(
        statusCode: statusCode,
        message: 'Персонаж не найден.',
      );
    } catch (e, s) {
      debugPrint('Error in $runtimeType.searchCharacters: $e\n$s');
      throw ApiException(message: 'Ошибка при поиске персонажей.');
    }
  }

  Future<void> addToFavorite(int id) async => await _box.put(id, true);
  Future<void> removeFromFavorite(int id) async => await _box.delete(id);

  Future<void> _initialize() async {
    _box.listenable().addListener(() {
      final favorites = getFavorites();

      _controller.sink.add(favorites);
    });
  }

  Future<void> dispose() async => await _controller.close();

  List<int> getFavorites() => _box.keys.whereType<int>().cast<int>().toList();
}
