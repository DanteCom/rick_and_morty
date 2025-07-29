part of 'characters_bloc.dart';

abstract class CharactersState extends Equatable {}

class CharactersLoaded extends CharactersState {
  final int page;
  final bool searchError;
  final CharacterInfo info;
  final List<Character> characters;

  CharactersLoaded({
    required this.info,
    required this.page,
    this.searchError = false,
    required this.characters,
  });

  CharactersLoaded copyWith({
    int? page,
    bool? isFiltered,
    bool? searchError,
    CharacterInfo? info,
    List<Character>? characters,
  }) {
    return CharactersLoaded(
      info: info ?? this.info,
      page: page ?? this.page,
      characters: characters ?? this.characters,
      searchError: searchError ?? this.searchError,
    );
  }

  @override
  List<Object> get props => [page, searchError, info, characters];
}

class CharactersError extends CharactersState {
  final String message;

  CharactersError({required this.message});

  @override
  List<Object?> get props => [message];
}

class CharactersInitial extends CharactersState {
  @override
  List<Object> get props => [];
}

class CharactersLoading extends CharactersState {
  @override
  List<Object?> get props => [];
}
