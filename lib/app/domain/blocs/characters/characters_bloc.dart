import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/app/domain/models/character.dart';
import 'package:rick_and_morty/app/services/character_service.dart';

part 'characters_event.dart';
part 'characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final _service = CharacterService();

  CharactersBloc() : super(CharactersInitial()) {
    on<GetAllCharacters>(_onGetAllCharacters);
    add(GetAllCharacters(page: 0));
  }

  Future<void> _onGetAllCharacters(
    GetAllCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersLoading());

    try {
      final characters = await _service.getAllCharacters(page: event.page);

      emit(CharactersLoaded(characters: characters));
    } catch (e, s) {
      debugPrint('Error in CharacterBloc: $e\n$s');

      final message = e.toString().replaceFirst('Exception: ', '');
      emit(CharactersError(message: message));
    }
  }
}
