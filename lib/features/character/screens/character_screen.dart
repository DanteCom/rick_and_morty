import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/app/theme/theme.dart';
import 'package:rick_and_morty/features/character/models/episode.dart';
import 'package:rick_and_morty/features/character/widgets/widgets.dart';
import 'package:rick_and_morty/features/character/bloc/character_bloc.dart';

class CharacterScreen extends StatelessWidget {
  final int id;

  const CharacterScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final bloc = context.read<CharacterBloc>();
    Color getStatusColor(bool isAlive, BuildContext context) {
      return isAlive ? context.color.activeStatus : context.color.disableStatus;
    }

    return Scaffold(
      body: BlocBuilder<CharacterBloc, CharacterState>(
        builder: (context, state) {
          if (state is CharacterLoaded) {
            final episodes = state.episodes;
            final character = state.character;
            final isCharacterAlive = character.status == "Alive";

            return ListView(
              padding: EdgeInsets.only(bottom: 40),
              physics: ClampingScrollPhysics(),
              children: [
                CharacterAppBar(
                  onHeart: () {},
                  character: character,
                  onBack: () => context.pop(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    children: [
                      SizedBox(height: 15),
                      Column(
                        spacing: 2,
                        children: [
                          Text(
                            character.name,
                            textAlign: TextAlign.center,
                            style: FontStyles.s24w500rb(color.text),
                          ),
                          Text(
                            character.status,
                            textAlign: TextAlign.center,
                            style: FontStyles.s20w500in(
                              getStatusColor(isCharacterAlive, context),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 36),
                      Text(
                        'Главный протагонист мультсериала «Рик и Морти». Безумный ученый, чей алкоголизм, безрассудность и социопатия заставляют беспокоиться семью его дочери.',
                        style: FontStyles.s15w500rb(color.text),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 24),
                        child: Column(
                          spacing: 20,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    spacing: 4,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Пол',
                                        style: FontStyles.s12w400rb(
                                          color.hintText,
                                        ),
                                      ),
                                      Text(
                                        character.gender,
                                        style: FontStyles.s14w400rb(color.text),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    spacing: 4,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Расса',
                                        style: FontStyles.s12w400rb(
                                          color.hintText,
                                        ),
                                      ),
                                      Text(
                                        character.species,
                                        style: FontStyles.s14w400rb(color.text),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              spacing: 24,
                              children: [
                                CharacterInfoButton(
                                  title: 'Место рождения',
                                  subtitle: character.origin.name,
                                  onPressed: () {},
                                ),
                                CharacterInfoButton(
                                  title: 'Местоположение',
                                  subtitle: character.location.name,
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Divider(color: color.foreground, thickness: 3),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(children: [_buildEpisodes(episodes, color)]),
                ),
              ],
            );
          } else if (state is CharacterError) {
            final message = state.message;

            return _buildErrorState(
              message,
              color,
              onRepeat: () => bloc.add(GetCharacter(id: id)),
            );
          } else {
            return Center(child: CupertinoActivityIndicator(color: color.text));
          }
        },
      ),
    );
  }

  Widget _buildEpisodes(List<Episode> episodes, AppColorTheme color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Эпизоды', style: FontStyles.s20w500rb(color.text)),
            Text('Все эпизоды', style: FontStyles.s12w400rb(color.hintText)),
          ],
        ),
        SizedBox(height: 24),
        Column(
          spacing: 24,
          children: List.generate(episodes.length, (index) {
            final episode = episodes[index];
            return EpisodeCard(episode: episode, onPressed: () {});
          }),
        ),
      ],
    );
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
}
