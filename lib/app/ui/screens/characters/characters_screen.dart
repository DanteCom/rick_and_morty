import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/app/domain/models/models.dart';
import 'package:rick_and_morty/app/ui/theme/theme.dart';
import 'package:rick_and_morty/app/router/app_routes.dart';
import 'package:rick_and_morty/app/domain/blocs/blocs.dart';
import 'package:rick_and_morty/app/ui/screens/characters/widgets/widgets.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  bool _isGrid = false;
  late TextEditingController _controller;
  final List<Character> _sortedCharacters = [];

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

  void searchCharacter(List<Character> characters, String name) {
    _sortedCharacters.clear();

    if (name.isEmpty) return setState(() {});

    _sortedCharacters.addAll(
      characters.where(
        (c) => c.name.toLowerCase().contains(name.toLowerCase()),
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final bloc = context.read<CharactersBloc>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16).copyWith(top: 10),
            child: BlocBuilder<CharactersBloc, CharactersState>(
              builder: (context, state) {
                if (state is CharactersLoaded) {
                  final characters = state.characters;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CharacterScreenAppBar(
                        onGrid: onGrid,
                        isGridActive: _isGrid,
                        characters: characters,
                        controller: _controller,
                        onChanged: (name) => searchCharacter(characters, name),
                      ),
                      Expanded(
                        child: _isGrid
                            ? GridView.builder(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 24,
                                      mainAxisExtent: 200,
                                      crossAxisSpacing: 16,
                                    ),
                                itemCount: _sortedCharacters.isEmpty
                                    ? characters.length
                                    : _sortedCharacters.length,
                                itemBuilder: (context, index) {
                                  final character = _sortedCharacters.isEmpty
                                      ? characters[index]
                                      : _sortedCharacters[index];
                                  final id = character.id;

                                  return CharacterCardDoubleColumn(
                                    character: character,
                                    onPressed: () => onCharacter(id),
                                  );
                                },
                              )
                            : ListView.separated(
                                itemCount: _sortedCharacters.isEmpty
                                    ? characters.length
                                    : _sortedCharacters.length,
                                padding: EdgeInsets.symmetric(vertical: 10),
                                separatorBuilder: (context, index) => Gap(24),
                                itemBuilder: (context, index) {
                                  final character = _sortedCharacters.isEmpty
                                      ? characters[index]
                                      : _sortedCharacters[index];
                                  final id = character.id;

                                  return CharacterCardSingleColumn(
                                    character: character,
                                    onPressed: () => onCharacter(id),
                                  );
                                },
                              ),
                      ),
                    ],
                  );
                } else if (state is CharactersError) {
                  final message = state.message;

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
                            color: color.hintText,
                            onPressed: () =>
                                bloc.add(GetAllCharacters(page: 1)),
                            child: Text(
                              'Повторить',
                              style: FontStyles.s16w500rb(color.text),
                            ),
                          ),
                        ),
                      ],
                    ),
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
        ),
      ),
    );
  }
}
