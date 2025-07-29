import 'dart:async';

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:rick_and_morty/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character/service/character_service.dart';
import 'package:rick_and_morty/features/character/models/character.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final _service = CharacterService();
  late final StreamSubscription<List<int>> _subscription;

  CharactersBloc() : super(CharactersInitial()) {
    on<GetAllCharacters>(_onGetAllCharacters);
    on<SearchCharacters>(_onSearchCharacters);
    on<FavoritesUpdated>(_onFavoritesUpdated);
    add(GetAllCharacters(page: 1));

    _subscription = _service.streamFavorites.listen((List<int> favorites) {
      add(FavoritesUpdated(favorites: favorites));
    });
  }

  Future<void> _onGetAllCharacters(
    GetAllCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    final currentPage = event.page;

    final isLoaded = state is CharactersLoaded;

    if (!isLoaded) emit(CharactersLoading());

    try {
      final response = await _service.getAllCharacters(page: currentPage);
      final info = response.info;
      final characters = response.characters;
      final favorites = _service.getFavorites();

      final updatedCharacters = characters.map((e) {
        final isFavorite = favorites.contains(e.id);

        return e.copyWith(isFavorite: isFavorite);
      }).toList();

      emit(
        CharactersLoaded(
          info: info,
          page: currentPage,
          characters: updatedCharacters,
        ),
      );
    } on ApiException catch (e) {
      emit(CharactersError(message: e.message));
    } catch (e, s) {
      debugPrint('Error in $runtimeType.onGetAllCharacters: $e\n$s');
      emit(CharactersError(message: 'Произошла непредвиденная ошибка.'));
    }
  }

  Future<void> _onSearchCharacters(
    SearchCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    final name = event.name.trim();

    try {
      if (state is! CharactersLoaded) return;

      final currentState = state as CharactersLoaded;
      final currentPage = currentState.page;

      if (name.isEmpty) {
        return add(GetAllCharacters(page: currentPage));
      }

      final characters = await _service.searchCharacters(name);

      emit(
        currentState.copyWith(
          isFiltered: true,
          searchError: false,
          characters: characters,
        ),
      );
    } on ApiException catch (e) {
      final statusCode = e.statusCode;

      if (state is CharactersLoaded && statusCode == 404) {
        final currentState = state as CharactersLoaded;

        return emit(
          currentState.copyWith(
            characters: [],
            isFiltered: true,
            searchError: true,
          ),
        );
      }

      emit(CharactersError(message: e.message));
    } catch (e, s) {
      debugPrint('Error in $runtimeType.onSearchCharacters: $e\n$s');
      emit(CharactersError(message: 'Произошла непредвиденная ошибка.'));
    }
  }

  Future<void> _onFavoritesUpdated(
    FavoritesUpdated event,
    Emitter<CharactersState> emit,
  ) async {
    if (state is CharactersLoaded) {
      final currentState = state as CharactersLoaded;
      final favorites = event.favorites;

      final updatedCharacters = currentState.characters.map((character) {
        final isFavorite = favorites.contains(character.id);
        return character.copyWith(isFavorite: isFavorite);
      }).toList();

      emit(currentState.copyWith(characters: updatedCharacters));
    }
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
