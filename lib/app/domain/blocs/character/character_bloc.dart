import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/app/domain/models/character.dart';
import 'package:rick_and_morty/app/domain/models/episode.dart';
import 'package:rick_and_morty/app/services/character_service.dart';

part 'character_event.dart';
part 'character_state.dart';

class CharacterBloc extends Bloc<CharacterEvent, CharacterState> {
  final int id;
  final _service = CharacterService();

  CharacterBloc({required this.id}) : super(CharacterInitial()) {
    on<GetCharacter>(_onGetCharacter);
    add(GetCharacter(id: id));
  }

  Future<void> _onGetCharacter(
    GetCharacter event,
    Emitter<CharacterState> emit,
  ) async {
    emit(CharacterLoading());

    try {
      final character = await _service.getCharacter(event.id);
      final episodes = await _service.getAppEpisodes(character.episodes);

      emit(CharacterLoaded(character: character, episodes: episodes));
    } catch (e, s) {
      debugPrint('Error in CharacterBloc: $e\n$s');

      final message = e.toString().replaceFirst('Exception: ', '');
      emit(CharacterError(message: message));
    }
  }
}
