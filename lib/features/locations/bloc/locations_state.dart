part of 'locations_bloc.dart';

abstract class LocationsState extends Equatable {}

class LocationsLoaded extends LocationsState {
  final int page;
  final bool searchError;
  final LocationInfo info;
  final List<Location> locations;

  LocationsLoaded({
    required this.info,
    required this.page,
    required this.locations,
    this.searchError = false,
  });

  LocationsLoaded copyWith({
    int? page,
    bool? searchError,
    LocationInfo? info,
    List<Location>? locations,
  }) {
    return LocationsLoaded(
      info: info ?? this.info,
      page: page ?? this.page,
      locations: locations ?? this.locations,
      searchError: searchError ?? this.searchError,
    );
  }

  @override
  List<Object> get props => [searchError, info, locations];
}

class LocationsError extends LocationsState {
  final String message;

  LocationsError({required this.message});

  @override
  List<Object> get props => [message];
}

class LocationsInitial extends LocationsState {
  @override
  List<Object> get props => [];
}

class LocationsLoading extends LocationsState {
  @override
  List<Object> get props => [];
}
