import 'package:flutter/material.dart';
import 'package:rick_and_morty/app/shared/shared.dart';
import 'package:rick_and_morty/app/ui/theme/theme.dart';
import 'package:rick_and_morty/app/domain/models/models.dart';

class LocationsScreenAppBar extends StatelessWidget {
  final void Function(String)? onChanged;
  final TextEditingController controller;

  final List<Location> locations;

  const LocationsScreenAppBar({
    super.key,
    required this.locations,
    required this.onChanged,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final color = context.color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          onChanged: onChanged,
          style: FontStyles.s16w400in(color.text),
          decoration: InputDecoration(
            filled: true,
            hintText: 'Найти локацию',

            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            iconColor: AppColors.black,
            prefixIcon: Container(
              margin: EdgeInsets.symmetric(
                vertical: 12,
              ).copyWith(left: 15, right: 10),
              child: SvgIcon(Vectors.search),
            ),
            fillColor: color.fill,
            suffixIcon: Container(
              height: 24,
              margin: EdgeInsets.symmetric(vertical: 12),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border(
                  left: BorderSide(width: 1, color: color.hintText),
                ),
              ),
              child: SvgIcon(Vectors.filter, color: AppColors.steelGray),
            ),
            hintStyle: FontStyles.s16w400in(color.hintText),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide(style: BorderStyle.none),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide(style: BorderStyle.none),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide(style: BorderStyle.none),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20, bottom: 10),
          child: Text(
            'Всего локаций: ${locations.length}',
            style: FontStyles.s15w500in(context.color.hintText),
          ),
        ),
      ],
    );
  }
}
