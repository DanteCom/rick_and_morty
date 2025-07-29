import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/core.dart';
import 'package:rick_and_morty/features/character/models/character.dart';
import 'package:rick_and_morty/features/character/service/character_service.dart';

part 'favorites_event.dart';
part 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  final _service = CharacterService();

  late final StreamSubscription<List<int>> _subscription;

  FavoritesBloc() : super(FavoritesInitial()) {
    on<GetAllFavorites>(_onGetAllFavorites);
    add(GetAllFavorites());

    _subscription = _service.streamFavorites.listen((List<int> favorites) {
      add(GetAllFavorites());
    });
  }

  Future<void> _onGetAllFavorites(
    GetAllFavorites event,
    Emitter<FavoritesState> emit,
  ) async {
    final isLoaded = state is FavoritesLoaded;

    if (!isLoaded) emit(FavoritesLoading());

    try {
      final favorites = _service.getFavorites();

      final List<Character> characters = [];

      for (final id in favorites) {
        try {
          final character = (await _service.getCharacter(
            id,
          )).copyWith(isFavorite: true);

          characters.add(character);
        } on ApiException catch (e) {
          if (e.statusCode == 404) await _service.removeFromFavorite(id);
          debugPrint('Error in $runtimeType.onGetAllFavorites ${e.message}');
        } catch (e, s) {
          debugPrint('Error in $runtimeType.onGetAllFavorites: $e\n$s');
        }
      }

      emit(FavoritesLoaded(characters: characters));
    } catch (e, s) {
      debugPrint('Error in $runtimeType.onGetAllFavorites: $e\n$s');
      emit(FavoritesError(message: 'Произошла непредвиденная ошибка.'));
    }
  }

  @override
  Future<void> close() async {
    await _subscription.cancel();

    return super.close();
  }
}
