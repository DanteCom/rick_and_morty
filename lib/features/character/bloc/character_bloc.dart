import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rick_and_morty/core/core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character/service/character_service.dart';
import 'package:rick_and_morty/features/character/models/episode.dart';
import 'package:rick_and_morty/features/character/models/character.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final int id;
  final _service = CharacterService();
  late final StreamSubscription<List<int>> _subscription;

  CharacterBloc({required this.id}) : super(CharacterInitial()) {
    on<SetFavorite>(_onSetFavorite);
    on<GetCharacter>(_onGetCharacter);
    on<FavoritesUpdated>(_onFavoritesUpdated);
    add(GetCharacter(id: id));

    _subscription = _service.streamFavorites.listen((List<int> favorites) {
      add(FavoritesUpdated(favorites: favorites));
    });
  }

  Future<void> _onGetCharacter(
    GetCharacter event,
    Emitter<CharacterState> emit,
  ) async {
    final id = event.id;

    emit(CharacterLoading());

    try {
      final character = await _service.getCharacter(id);
      final episodes = await _service.getEpisodes(character.episodes);
      final favorites = _service.getFavorites();
      final isFavorite = favorites.contains(id);

      final updatedCharacter = character.copyWith(isFavorite: isFavorite);

      emit(CharacterLoaded(character: updatedCharacter, episodes: episodes));
    } on ApiException catch (e) {
      emit(CharacterError(message: e.message));
    } catch (e, s) {
      debugPrint('Error in $runtimeType.onGetCharacter: $e\n$s');
      emit(CharacterError(message: 'Произошла непредвиденная ошибка.'));
    }
  }

  Future<void> _onSetFavorite(
    SetFavorite event,
    Emitter<CharacterState> emit,
  ) async {
    final character = event.character;
    final id = character.id;

    character.isFavorite
        ? _service.removeFromFavorite(id)
        : _service.addToFavorite(id);
  }

  Future<void> _onFavoritesUpdated(
    FavoritesUpdated event,
    Emitter<CharacterState> emit,
  ) async {
    if (state is CharacterLoaded) {
      final currentState = state as CharacterLoaded;
      final isFavorite = event.favorites.contains(id);

      if (currentState.character.isFavorite != isFavorite) {
        final updatedCharacter = currentState.character.copyWith(
          isFavorite: isFavorite,
        );
        emit(currentState.copyWith(character: updatedCharacter));
      }
    }
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
