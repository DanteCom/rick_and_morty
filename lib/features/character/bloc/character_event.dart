part of 'character_bloc.dart';

abstract class CharacterEvent {}

class GetCharacter extends CharacterEvent {
  final int id;

  GetCharacter({required this.id});
}

class SetFavorite extends CharacterEvent {
  final Character character;

  SetFavorite({required this.character});
}

class FavoritesUpdated extends CharacterEvent {
  final List<int> favorites;

  FavoritesUpdated({required this.favorites});
}
