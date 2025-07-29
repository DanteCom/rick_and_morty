import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/features/character/bloc/character_bloc.dart';
import 'package:rick_and_morty/shared/shared.dart';
import 'package:rick_and_morty/app/theme/theme.dart';
import 'package:rick_and_morty/features/character/models/character.dart';

class CharacterAppBar extends StatelessWidget {
  const CharacterAppBar({
    super.key,
    required this.onBack,
    required this.onHeart,
    required this.character,
  });

  final Character character;
  final void Function()? onBack;
  final void Function()? onHeart;

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final isFavorite = character.isFavorite;
    final bloc = context.read<CharacterBloc>();

    return SizedBox(
      height: 330,
      width: double.infinity,
      child: Stack(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Positioned.fill(child: AppNetworkImage(url: character.image)),
                Positioned.fill(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [.0, .37, .69],
                        colors: [
                          AppColors.black.withValues(alpha: .65),
                          Color(0xFF0B1E2D).withValues(alpha: .20),
                          Color(0xFF0B1E2D).withValues(alpha: .20),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(0xFF0B1E2D).withValues(alpha: .65),
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  top: MediaQuery.of(context).padding.top,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: onBack,
                        child: SvgIcon(
                          Vectors.arrowBack,
                          fit: BoxFit.cover,
                          color: color.text,
                        ),
                      ),
                      CupertinoButton(
                        padding: EdgeInsets.zero,
                        onPressed: () =>
                            bloc.add(SetFavorite(character: character)),
                        child: SvgIcon(
                          isFavorite ? Vectors.heart : Vectors.heartOutline,
                          fit: BoxFit.cover,
                          color: isFavorite ? AppColors.red : color.text,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: 178,
              height: 178,
              padding: EdgeInsets.all(8),
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.background,
              ),
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: AppNetworkImage(
                  url: character.image,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
