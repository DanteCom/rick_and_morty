import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty/app/domain/models/character.dart';
import 'package:rick_and_morty/app/domain/models/episode.dart';

class CharacterService {
  final _dio = Dio();

  Future<List<Character>> getAllCharacters({int page = 1}) async {
    final url = "https://rickandmortyapi.com/api/character?page=$page";

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is! Map || data['results'] is! List) {
          throw Exception('Неверный формат данных от API');
        }

        final results = data['results'] as List;
        return results.map((json) => Character.fromJson(json)).toList();
      } else {
        throw Exception('Ошибка от сервера: ${response.statusCode}');
      }
    } catch (e, s) {
      debugPrint('Error in $runtimeType.getAllCharacters: $e\n$s');
      throw Exception('Упс... что-то пошло не так');
    }
  }

  Future<Character> getCharacter(int id) async {
    final url = "https://rickandmortyapi.com/api/character/$id";

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200) {
        final data = response.data;
        if (data is! Map<String, dynamic>) {
          throw Exception('Неверный формат данных от API');
        }

        return Character.fromJson(data);
      } else {
        throw Exception('Ошибка от сервера: ${response.statusCode}');
      }
    } catch (e, s) {
      debugPrint('Error in $runtimeType.getCharacter: $e\n$s');
      throw Exception('Упс... что-то пошло не так');
    }
  }

  Future<List<Episode>> getAppEpisodes(List<String> urls) async {
    try {
      final responses = await Future.wait(urls.map((url) => _dio.get(url)));

      final episodes = <Episode>[];

      for (final response in responses) {
        if (response.statusCode == 200) {
          final data = response.data;
          if (data is! Map<String, dynamic>) {
            throw Exception('Неверный формат данных от API');
          }
          episodes.add(Episode.fromJson(data));
        } else {
          throw Exception('Ошибка от сервера: ${response.statusCode}');
        }
      }

      return episodes;
    } catch (e, s) {
      debugPrint('Error in $runtimeType.getAppEpisodes: $e\n$s');
      throw Exception('Упс... что-то пошло не так');
    }
  }
}
