import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/shared/shared.dart';
import 'package:rick_and_morty/app/theme/theme.dart';
import 'package:rick_and_morty/features/locations/model/location.dart';
import 'package:rick_and_morty/features/locations/widgets/widgets.dart';
import 'package:rick_and_morty/features/locations/bloc/locations_bloc.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _controller.clear();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LocationsBloc>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ).copyWith(top: 10),
            child: Column(
              children: [
                BlocBuilder<LocationsBloc, LocationsState>(
                  builder: (context, state) {
                    bool isLoaded = (state is LocationsLoaded);

                    return LocationsScreenAppBar(
                      controller: _controller,
                      onChanged: (name) =>
                          bloc.add(SearchLocations(name: name)),
                      locations: isLoaded ? state.locations : [],
                    );
                  },
                ),
                Expanded(
                  child: BlocBuilder<LocationsBloc, LocationsState>(
                    builder: (context, state) {
                      if (state is LocationsLoaded) {
                        final locations = state.locations;

                        return state.searchError
                            ? _buildSearchErrorState()
                            : _buildListLocations(locations);
                      } else if (state is LocationsError) {
                        final message = state.message;

                        return _buildErrorState(
                          message,
                          onRepeat: () => bloc.add(GetAllLocations(page: 0)),
                        );
                      } else {
                        return Center(
                          child: CupertinoActivityIndicator(
                            color: context.color.text,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Column _buildErrorState(
    String message, {
    required void Function()? onRepeat,
  }) {
    final color = context.color;
    return Column(
      spacing: 20,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          message,
          maxLines: 2,
          textAlign: TextAlign.center,
          style: FontStyles.s20w500in(color.text),
        ),
        SizedBox(
          width: double.infinity,
          child: CupertinoButton(
            onPressed: onRepeat,
            color: color.hintText,
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text('Повторить', style: FontStyles.s16w500rb(color.text)),
          ),
        ),
      ],
    );
  }

  ListView _buildListLocations(List<Location> locations) {
    return ListView.separated(
      itemCount: locations.length,
      separatorBuilder: (context, index) => SizedBox(height: 24),
      itemBuilder: (context, index) {
        final location = locations[index];

        return LocationCard(location: location);
      },
    );
  }

  Column _buildSearchErrorState() {
    final color = context.color;
    return Column(
      spacing: 28,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: Image.asset(height: 135, Images.planet, fit: BoxFit.fitWidth),
        ),
        Text(
          'Локации с таким\nназванием не найдено',
          textAlign: TextAlign.center,
          style: FontStyles.s16w500rb(color.hintText),
        ),
      ],
    );
  }
}
