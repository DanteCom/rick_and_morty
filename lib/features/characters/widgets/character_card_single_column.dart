import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty/shared/shared.dart';
import 'package:rick_and_morty/app/theme/theme.dart';
import 'package:rick_and_morty/features/character/models/character.dart';

class CharacterCardSingleColumn extends StatelessWidget {
  final Character character;
  final void Function()? onPressed;

  const CharacterCardSingleColumn({
    super.key,
    required this.character,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final isFavorite = character.isFavorite;
    final isCharacterAlive = character.status == "Alive";

    Color getStatusColor(bool isAlive, BuildContext context) {
      return isAlive ? context.color.activeStatus : context.color.disableStatus;
    }

    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Row(
        spacing: 18,
        children: [
          Container(
            width: 74,
            height: 74,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: AppNetworkImage(url: character.image),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  spacing: 5,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.status,
                      style: FontStyles.s10w500rb(
                        getStatusColor(isCharacterAlive, context),
                      ),
                    ),
                    Text(
                      maxLines: 1,
                      character.name,
                      overflow: TextOverflow.ellipsis,
                      style: FontStyles.s16w500rb(context.color.text),
                    ),
                    Text(
                      '${character.species}, ${character.gender}',
                      style: FontStyles.s12w400rb(AppColors.slateGray),
                    ),
                  ],
                ),
                SvgIcon(
                  isFavorite ? Vectors.heart : Vectors.heartOutline,
                  fit: BoxFit.cover,
                  color: isFavorite ? AppColors.red : color.text,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
