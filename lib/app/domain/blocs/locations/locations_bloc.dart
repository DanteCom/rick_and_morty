import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/app/domain/models/models.dart';
import 'package:rick_and_morty/app/services/location_service.dart';

part 'locations_event.dart';
part 'locations_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final _service = LocationService();

  LocationsBloc() : super(LocationsInitial()) {
    on<GetAllLocations>(_onGetAllLocations);
    add(GetAllLocations());
  }

  Future<void> _onGetAllLocations(
    GetAllLocations event,
    Emitter<LocationsState> emit,
  ) async {
    emit(LocationsLoading());

    try {
      final locations = await _service.getAllLocations();

      emit(LocationsLoaded(locations: locations));
    } catch (e, s) {
      debugPrint('Error in CharacterBloc: $e\n$s');

      final message = e.toString().replaceFirst('Exception: ', '');
      emit(LocationsError(message: message));
    }
  }
}
