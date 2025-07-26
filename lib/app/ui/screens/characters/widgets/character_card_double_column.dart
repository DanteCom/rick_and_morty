import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty/app/shared/shared.dart';
import 'package:rick_and_morty/app/ui/theme/theme.dart';
import 'package:rick_and_morty/app/domain/models/character.dart';

class CharacterCardDoubleColumn extends StatelessWidget {
  final Character character;
  final void Function()? onPressed;

  const CharacterCardDoubleColumn({
    super.key,
    required this.character,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final isCharacterAlive = character.status == "Alive";

    Color getStatusColor(bool isAlive, BuildContext context) {
      return isAlive ? context.color.activeStatus : context.color.disableStatus;
    }

    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Column(
        spacing: 18,
        children: [
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(shape: BoxShape.circle),
              child: AppNetworkImage(url: character.image),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  maxLines: 1,
                  character.status,
                  textAlign: TextAlign.center,
                  style: FontStyles.s10w500rb(
                    getStatusColor(isCharacterAlive, context),
                  ),
                ),
                Text(
                  maxLines: 1,
                  character.name,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: FontStyles.s14w500rb(context.color.text),
                ),
                Text(
                  maxLines: 1,
                  '${character.species}, ${character.gender}',
                  textAlign: TextAlign.center,
                  style: FontStyles.s12w400rb(AppColors.slateGray),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
