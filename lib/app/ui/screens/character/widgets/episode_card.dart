import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty/app/shared/shared.dart';
import 'package:rick_and_morty/app/ui/theme/theme.dart';
import 'package:rick_and_morty/app/domain/models/models.dart';

class EpisodeCard extends StatelessWidget {
  const EpisodeCard({
    super.key,
    required this.episode,
    required this.onPressed,
  });

  final Episode episode;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final color = context.color;

    return SizedBox(
      height: 74,
      child: CupertinoButton(
        padding: EdgeInsets.zero,
        onPressed: onPressed,
        child: Row(
          spacing: 16,
          children: [
            Container(
              height: 74,
              width: 74,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(Images.episode, fit: BoxFit.cover),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    maxLines: 1,
                    "Серия ${episode.id}".toUpperCase(),
                    style: FontStyles.s10w500rb(color.activeButton),
                  ),
                  Text(
                    maxLines: 1,
                    episode.name,
                    style: FontStyles.s15w500rb(color.text),
                  ),
                  Text(
                    maxLines: 1,
                    episode.airDate,
                    style: FontStyles.s14w500rb(color.hintText),
                  ),
                ],
              ),
            ),
            SvgIcon(Vectors.arrowRight, color: color.text),
          ],
        ),
      ),
    );
  }
}
