import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:rick_and_morty/shared/shared.dart';
import 'package:rick_and_morty/app/theme/theme.dart';

class AppShellScreen extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const AppShellScreen({super.key, required this.navigationShell});

  @override
  State<AppShellScreen> createState() => _AppShellScreenState();
}

class _AppShellScreenState extends State<AppShellScreen> {
  void onCharacters() => widget.navigationShell.goBranch(0);
  void onLocations() => widget.navigationShell.goBranch(1);
  void onEpisodes() => widget.navigationShell.goBranch(2);
  void onSettings() => widget.navigationShell.goBranch(3);

  int get currentIndex => widget.navigationShell.currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.navigationShell,
      bottomNavigationBar: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: context.color.foreground),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Tabbs(
                        title: 'Персонажи',
                        icon: Vectors.character,
                        isActive: currentIndex == 0,
                        onPressed: currentIndex == 0 ? null : onCharacters,
                      ),
                    ),
                    Expanded(
                      child: Tabbs(
                        title: 'Локации',
                        icon: Vectors.location,
                        isActive: currentIndex == 1,
                        onPressed: currentIndex == 1 ? null : onLocations,
                      ),
                    ),
                    Expanded(
                      child: Tabbs(
                        width: 20,
                        height: 20,
                        title: 'Избранные',
                        icon: Vectors.heartOutline,
                        isActive: currentIndex == 2,
                        onPressed: currentIndex == 2 ? null : onEpisodes,
                      ),
                    ),
                    Expanded(
                      child: Tabbs(
                        title: 'Настройки',
                        icon: Vectors.settings,
                        isActive: currentIndex == 3,
                        onPressed: currentIndex == 3 ? null : onSettings,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Tabbs extends StatelessWidget {
  final String icon;
  final String title;
  final double width;
  final double height;
  final bool isActive;
  final void Function()? onPressed;

  const Tabbs({
    super.key,
    this.width = 24,
    this.height = 24,
    required this.icon,
    required this.title,
    required this.isActive,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive
        ? context.color.activeButton
        : context.color.disableButton;

    return CupertinoButton(
      onPressed: onPressed,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          SvgIcon(
            icon,
            width: width,
            color: color,
            height: height,
            fit: BoxFit.contain,
          ),
          Text(title, style: FontStyles.s12w400in(color)),
        ],
      ),
    );
  }
}
