part of 'characters_bloc.dart';

abstract class CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<Character> characters;

  CharactersLoaded({required this.characters});
}

class CharactersError extends CharactersState {
  final String message;

  CharactersError({required this.message});
}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}
