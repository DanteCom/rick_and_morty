import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/app/router/app_routes.dart';
import 'package:rick_and_morty/app/theme/theme.dart';
import 'package:rick_and_morty/features/favorites/bloc/favorites_bloc.dart';
import 'package:rick_and_morty/features/characters/widgets/character_card_single_column.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final bloc = context.read<FavoritesBloc>();

    return Scaffold(
      appBar: AppBar(
        title: Text('Избранные', style: FontStyles.s24w500rb(color.text)),
        backgroundColor: color.foreground,
      ),
      body: SafeArea(
        child: Center(
          child: BlocBuilder<FavoritesBloc, FavoritesState>(
            builder: (context, state) {
              if (state is FavoritesLoaded) {
                final characters = state.characters;
                return ListView.separated(
                  itemCount: characters.length,
                  physics: ClampingScrollPhysics(),
                  separatorBuilder: (context, index) => SizedBox(height: 20),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  itemBuilder: (context, index) {
                    final character = characters[index];
                    final id = character.id;

                    return CharacterCardSingleColumn(
                      onPressed: () => context.pushNamed(
                        AppRoutes.character.name,
                        pathParameters: {'id': '$id'},
                      ),
                      character: character,
                    );
                  },
                );
              } else if (state is FavoritesError) {
                final message = state.message;

                return _buildErrorState(
                  message,
                  color,
                  onRepeat: () => bloc.add(GetAllFavorites()),
                );
              } else {
                return CupertinoActivityIndicator(color: color.text);
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget _buildErrorState(
  String message,
  AppColorTheme color, {
  required void Function()? onRepeat,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16),
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
            onPressed: onRepeat,
            child: Text('Повторить', style: FontStyles.s16w500rb(color.text)),
          ),
        ),
      ],
    ),
  );
}
