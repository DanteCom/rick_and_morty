import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty/shared/shared.dart';
import 'package:rick_and_morty/app/theme/theme.dart';
import 'package:rick_and_morty/features/locations/model/location.dart';

class LocationCard extends StatelessWidget {
  const LocationCard({super.key, required this.location});

  final Location location;

  @override
  Widget build(BuildContext context) {
    final color = context.color;

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
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.name,
                    style: FontStyles.s20w500rb(context.color.text),
                  ),
                  Text(
                    location.dimension,
                    style: FontStyles.s14w400rb(context.color.hintText),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
