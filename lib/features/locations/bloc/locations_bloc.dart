import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/core/error/api_exception.dart';
import 'package:rick_and_morty/features/locations/service/location_service.dart';
import 'package:rick_and_morty/features/locations/model/location.dart';

part 'locations_event.dart';
part 'locations_state.dart';

class LocationsBloc extends Bloc<LocationsEvent, LocationsState> {
  final _service = LocationService();

  LocationsBloc() : super(LocationsInitial()) {
    on<GetAllLocations>(_onGetAllLocations);
    on<SearchLocations>(_onSearchLocations);

    add(GetAllLocations(page: 0));
  }

  Future<void> _onGetAllLocations(
    GetAllLocations event,
    Emitter<LocationsState> emit,
  ) async {
    final currentPage = event.page;

    final isLoaded = state is LocationsLoaded;

    if (!isLoaded) emit(LocationsLoading());

    try {
      final response = await _service.getAllLocations();
      final info = response.info;
      final locations = response.locations;

      emit(
        LocationsLoaded(info: info, page: currentPage, locations: locations),
      );
    } on ApiException catch (e) {
      emit(LocationsError(message: e.message));
    } catch (e, s) {
      debugPrint('Error in $runtimeType.onGetAllLocations: $e\n$s');
      emit(LocationsError(message: 'Произошла непредвиденная ошибка.'));
    }
  }

  Future<void> _onSearchLocations(
    SearchLocations event,
    Emitter<LocationsState> emit,
  ) async {
    final name = event.name.trim();

    try {
      if (state is! LocationsLoaded) return;

      final currentState = state as LocationsLoaded;
      final currentPage = currentState.page;

      if (name.isEmpty) return add(GetAllLocations(page: currentPage));

      final locations = await _service.searchLocations(name);

      emit(currentState.copyWith(searchError: false, locations: locations));
    } on ApiException catch (e) {
      final statusCode = e.statusCode;

      if (state is LocationsLoaded && statusCode == 404) {
        final currentState = state as LocationsLoaded;

        return emit(currentState.copyWith(locations: [], searchError: true));
      }

      emit(LocationsError(message: e.message));
    } catch (e, s) {
      debugPrint('Error in $runtimeType.onSearchCharacters: $e\n$s');
      emit(LocationsError(message: 'Произошла непредвиденная ошибка.'));
    }
  }
}
