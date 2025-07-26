import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/app/domain/cubits/app_theme/app_theme_cubit.dart';
import 'package:rick_and_morty/app/ui/theme/theme.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.color;
    final themeCubit = context.watch<AppThemeCubit>();
    final mode = themeCubit.state;

    void onDark() => themeCubit.changeTheme(ThemeMode.dark);
    void onLight() => themeCubit.changeTheme(ThemeMode.light);
    void onSystem() => themeCubit.changeTheme(ThemeMode.system);

    return Scaffold(
      appBar: AppBar(
        title: Text('Settings', style: FontStyles.s24w500rb(color.text)),
        backgroundColor: color.foreground,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          spacing: 16,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Change Theme', style: FontStyles.s20w500in(color.text)),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: color.hintText,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SettingsButton(
                    title: 'Dark',
                    onPressed: onDark,
                    isActive: mode == ThemeMode.dark,
                  ),
                  SettingsButton(
                    title: 'Light',
                    onPressed: onLight,
                    isActive: mode == ThemeMode.light,
                  ),
                  SettingsButton(
                    title: 'System',
                    onPressed: onSystem,
                    isActive: mode == ThemeMode.system,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  final String title;
  final bool isActive;
  final void Function()? onPressed;

  const SettingsButton({
    super.key,
    required this.title,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = context.color;

    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Row(
        children: [
          Expanded(
            child: Text(title, style: FontStyles.s20w500in(AppColors.black)),
          ),
          Container(
            width: 15,
            height: 15,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.activeButton,
            ),
            child: Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.background,
              ),
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive ? color.activeButton : Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
