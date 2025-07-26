import 'package:flutter/material.dart';
import 'package:rick_and_morty/app/ui/theme/theme.dart';

class EpisodesScreen extends StatelessWidget {
  const EpisodesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.color;

    return Scaffold(
      body: Center(
        child: Text('Episodes', style: FontStyles.s20w500in(color.text)),
      ),
    );
  }
}
