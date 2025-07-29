import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/app/theme/app_colors/app_color_theme.dart';
import 'package:rick_and_morty/app/theme/cubit/app_theme_cubit.dart';

class AppTheme {
  final String? fontFamily;
  final AppColorTheme color;

  static const _inter = 'Inter';

  static final light = AppTheme._(
    fontFamily: _inter,
    color: AppColorTheme.light,
  );

  static final dark = AppTheme._(fontFamily: _inter, color: AppColorTheme.dark);

  const AppTheme._({required this.fontFamily, required this.color});

  static AppTheme _fromMode(BuildContext context, ThemeMode mode) {
    final brightness = MediaQuery.platformBrightnessOf(context);
    final system = brightness == Brightness.dark ? dark : light;

    return switch (mode) {
      ThemeMode.dark => dark,
      ThemeMode.light => light,
      ThemeMode.system => system,
    };
  }

  static AppTheme of(BuildContext context) {
    final mode = context.watch<AppThemeCubit>().state;

    return AppTheme._fromMode(context, mode);
  }
}

extension AppThemeExtension on BuildContext {
  AppTheme get theme => AppTheme.of(this);
}
