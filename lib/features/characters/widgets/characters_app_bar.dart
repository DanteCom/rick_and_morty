import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty/shared/shared.dart';
import 'package:rick_and_morty/app/theme/theme.dart';
import 'package:rick_and_morty/features/character/models/character.dart';

class CharacterAppBar extends StatelessWidget {
  final bool isGridActive;
  final void Function()? onGrid;
  final List<Character> characters;
  final void Function(String)? onChanged;
  final TextEditingController controller;

  const CharacterAppBar({
    super.key,
    required this.onGrid,
    required this.onChanged,
    required this.controller,
    required this.characters,
    required this.isGridActive,
  });

  @override
  Widget build(BuildContext context) {
    final color = context.color;

    return Column(
      children: [
        TextField(
          onChanged: onChanged,
          controller: controller,
          style: FontStyles.s16w400in(color.text),
          decoration: InputDecoration(
            filled: true,
            hintText: 'Найти персонажа',
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            iconColor: AppColors.black,
            prefixIcon: Container(
              margin: EdgeInsets.symmetric(
                vertical: 12,
              ).copyWith(left: 15, right: 10),
              child: SvgIcon(Vectors.search),
            ),
            fillColor: context.color.fill,
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20, bottom: 10),
              child: Text(
                'Всего персонажей: ${characters.length}',
                style: FontStyles.s15w500in(context.color.hintText),
              ),
            ),
            CupertinoButton(
              onPressed: onGrid,
              padding: EdgeInsets.zero,
              child: SvgIcon(
                color: context.color.hintText,
                isGridActive ? Vectors.menu : Vectors.grid,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
