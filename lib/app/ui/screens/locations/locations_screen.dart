import 'package:gap/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/app/shared/shared.dart';
import 'package:rick_and_morty/app/ui/theme/theme.dart';
import 'package:rick_and_morty/app/domain/models/location.dart';
import 'package:rick_and_morty/app/domain/blocs/locations/locations_bloc.dart';
import 'package:rick_and_morty/app/ui/screens/locations/widgets/locations_screen_app_bar.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  late TextEditingController _controller;
  final List<Location> _sortedLocations = [];

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

  void searchLocation(List<Location> locations, String name) {
    _sortedLocations.clear();

    if (name.isEmpty) return setState(() {});

    _sortedLocations.addAll(
      locations.where((c) => c.name.toLowerCase().contains(name.toLowerCase())),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final bloc = context.read<LocationsBloc>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ).copyWith(top: 10),
            child: BlocBuilder<LocationsBloc, LocationsState>(
              builder: (context, state) {
                if (state is LocationsLoaded) {
                  final locations = state.locations;
                  return Column(
                    children: [
                      LocationsScreenAppBar(
                        locations: locations,
                        controller: _controller,
                        onChanged: (name) => searchLocation(locations, name),
                      ),
                      Expanded(
                        child: ListView.separated(
                          itemCount: _sortedLocations.isEmpty
                              ? locations.length
                              : _sortedLocations.length,
                          separatorBuilder: (context, index) => Gap(24),
                          itemBuilder: (context, index) {
                            final location = _sortedLocations.isEmpty
                                ? locations[index]
                                : _sortedLocations[index];

                            return CupertinoButton(
                              onPressed: () {},
                              padding: EdgeInsets.zero,
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: color.fill,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(Images.location),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 12,
                                        horizontal: 16,
                                      ),
                                      child: Column(
                                        spacing: 4,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            location.name,
                                            style: FontStyles.s20w500rb(
                                              context.color.text,
                                            ),
                                          ),
                                          Text(
                                            location.dimension,
                                            style: FontStyles.s14w400rb(
                                              context.color.hintText,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                } else if (state is LocationsError) {
                  final message = state.message;

                  return Center(
                    child: Column(
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
                            padding: EdgeInsets.symmetric(vertical: 15),
                            color: color.hintText,
                            onPressed: () => bloc.add(GetAllLocations()),
                            child: Text(
                              'Повторить',
                              style: FontStyles.s16w500rb(color.text),
                            ),
                          ),
                        ),
                      ],
                    ),
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
        ),
      ),
    );
  }
}
