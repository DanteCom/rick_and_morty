part of 'character_bloc.dart';

abstract class CharacterEvent {}

class GetCharacter extends CharacterEvent {
  final int id;

  GetCharacter({required this.id});
}
