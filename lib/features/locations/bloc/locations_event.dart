part of 'locations_bloc.dart';

abstract class LocationsEvent {}

class GetAllLocations extends LocationsEvent {
  final int page;

  GetAllLocations({required this.page});
}

class SearchLocations extends LocationsEvent {
  final String name;

  SearchLocations({required this.name});
}
