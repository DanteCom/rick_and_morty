part of 'character_bloc.dart';

abstract class CharacterState {}

class CharacterLoaded extends CharacterState {
  final Character character;
  final List<Episode> episodes;

  CharacterLoaded({required this.character, required this.episodes});
}

class CharacterError extends CharacterState {
  final String message;

  CharacterError({required this.message});
}

class CharacterInitial extends CharacterState {}

class CharacterLoading extends CharacterState {}
