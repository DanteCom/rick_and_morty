import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty/app/app.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rick_and_morty/features/character/service/character_service.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('settings');
  await Hive.openBox('characters');

  await CharacterService.initialize();

  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  runApp(const App());
}
