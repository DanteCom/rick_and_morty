import 'package:flutter/cupertino.dart';
import 'package:rick_and_morty/app/shared/shared.dart';
import 'package:rick_and_morty/app/ui/theme/theme.dart';

class CharacterInfoButton extends StatelessWidget {
  const CharacterInfoButton({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPressed,
  });

  final String title;
  final String subtitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Row(
        children: [
          Expanded(
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: FontStyles.s12w400rb(color.hintText)),
                Text(subtitle, style: FontStyles.s14w400rb(color.text)),
              ],
            ),
          ),
          SvgIcon(Vectors.arrowRight, color: color.text),
        ],
      ),
    );
  }
}
