import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppThemeCubit extends Cubit<ThemeMode> {
  final _box = Hive.box('settings');

  AppThemeCubit() : super(_initial()) {
    _box.listenable(keys: ['theme_mode']).addListener(_onBoxChanged);
  }

  static ThemeMode _initial() => _readFromBox();

  Future<void> changeTheme(ThemeMode mode) async {
    await _box.put('theme_mode', mode.name);
  }

  void _onBoxChanged() {
    final mode = _readFromBox();

    if (mode != state) emit(mode);
  }

  static ThemeMode _readFromBox() {
    final box = Hive.box('settings');
    final systemMode = ThemeMode.system;
    final name = box.get('theme_mode', defaultValue: systemMode.name);

    return ThemeMode.values.firstWhere(
      (mode) => mode.name == name,
      orElse: () => systemMode,
    );
  }

  @override
  Future<void> close() {
    _box.listenable(keys: ['theme_mode']).removeListener(_onBoxChanged);
    return super.close();
  }
}
