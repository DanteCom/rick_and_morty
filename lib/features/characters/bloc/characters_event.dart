part of 'characters_bloc.dart';

abstract class CharactersEvent extends Equatable {}

class GetAllCharacters extends CharactersEvent {
  final int page;

  GetAllCharacters({required this.page});

  @override
  List<Object> get props => [];
}

class SearchCharacters extends CharactersEvent {
  final int page;
  final String name;

  SearchCharacters({required this.name, required this.page});

  @override
  List<Object?> get props => [name, page];
}

class FavoritesUpdated extends CharactersEvent {
  final List<int> favorites;

  FavoritesUpdated({required this.favorites});

  @override
  List<Object?> get props => [favorites];
}
