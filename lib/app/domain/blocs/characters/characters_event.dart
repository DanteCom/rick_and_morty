part of 'characters_bloc.dart';

abstract class CharactersEvent {}

class GetAllCharacters extends CharactersEvent {
  final int page;

  GetAllCharacters({required this.page});
}
