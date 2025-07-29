import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/shared/shared.dart';
import 'package:rick_and_morty/app/theme/theme.dart';
import 'package:rick_and_morty/app/router/app_routes.dart';
import 'package:rick_and_morty/features/character/models/character.dart';
import 'package:rick_and_morty/features/characters/widgets/widgets.dart';
import 'package:rick_and_morty/features/characters/bloc/characters_bloc.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  bool _isGrid = false;
  late TextEditingController _controller;

  void onCharacter(int id) {
    context.goNamed(AppRoutes.character.name, pathParameters: {"id": "$id"});
  }

  void onGrid() => setState(() => _isGrid = !_isGrid);

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

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<CharactersBloc>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 10),
            child: Column(
              children: [
                BlocBuilder<CharactersBloc, CharactersState>(
                  builder: (context, state) {
                    bool isLoaded = (state is CharactersLoaded);

                    return CharacterAppBar(
                      onGrid: onGrid,
                      isGridActive: _isGrid,
                      controller: _controller,
                      onChanged: (name) =>
                          bloc.add(SearchCharacters(name: name, page: 1)),
                      characters: isLoaded ? state.characters : [],
                    );
                  },
                ),
                Expanded(
                  child: BlocBuilder<CharactersBloc, CharactersState>(
                    builder: (context, state) {
                      if (state is CharactersLoaded) {
                        final characters = state.characters;
                        final searchError = state.searchError;

                        return searchError
                            ? _buildSearchEmptyState()
                            : _isGrid
                            ? _buildGridCharacters(characters)
                            : _buildListCharacters(characters);
                      } else if (state is CharactersError) {
                        final message = state.message;

                        return _buildErrorState(
                          message,
                          onRepeat: () => bloc.add(GetAllCharacters(page: 1)),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  Center _buildErrorState(
    String message, {
    required void Function()? onRepeat,
  }) {
    final color = context.color;
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
              onPressed: onRepeat,
              color: color.hintText,
              child: Text('Повторить', style: FontStyles.s16w500rb(color.text)),
            ),
          ),
        ],
      ),
    );
  }

  ListView _buildListCharacters(List<Character> characters) {
    return ListView.separated(
      itemCount: characters.length,
      padding: EdgeInsets.symmetric(vertical: 10),
      separatorBuilder: (context, index) => SizedBox(height: 24),
      itemBuilder: (context, index) {
        final character = characters[index];
        final id = character.id;

        return CharacterCardSingleColumn(
          character: character,
          onPressed: () => onCharacter(id),
        );
      },
    );
  }

  GridView _buildGridCharacters(List<Character> characters) {
    return GridView.builder(
      itemCount: characters.length,
      padding: EdgeInsets.symmetric(vertical: 10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 24,
        mainAxisExtent: 200,
        crossAxisSpacing: 16,
      ),
      itemBuilder: (context, index) {
        final character = characters[index];
        final id = character.id;

        return CharacterCardDoubleColumn(
          character: character,
          onPressed: () => onCharacter(id),
        );
      },
    );
  }

  Widget _buildSearchEmptyState() {
    final color = context.color;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 28,
      children: [
        Flexible(child: Image.asset(Images.boy, width: 150, fit: BoxFit.fill)),
        Text(
          'Персонаж с таким именем\nне найден',
          textAlign: TextAlign.center,
          style: FontStyles.s16w500rb(color.hintText),
        ),
      ],
    );
  }
}
