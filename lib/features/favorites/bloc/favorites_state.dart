part of "favorites_bloc.dart";

abstract class FavoritesState {}

class FavoritesLoaded extends FavoritesState {
  final List<Character> characters;

  FavoritesLoaded({required this.characters});
}

class FavoritesLoading extends FavoritesState {}

class FavoritesInitial extends FavoritesState {}

class FavoritesError extends FavoritesState {
  final String message;

  FavoritesError({required this.message});
}
