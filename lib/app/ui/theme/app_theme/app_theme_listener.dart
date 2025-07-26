import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/app/domain/cubits/app_theme/app_theme_cubit.dart';

class AppThemeListener extends StatefulWidget {
  final Widget child;

  const AppThemeListener({super.key, required this.child});

  @override
  State<AppThemeListener> createState() => _AppThemeListenerState();
}

class _AppThemeListenerState extends State<AppThemeListener>
    with WidgetsBindingObserver {
  Brightness? _lastBrightness;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    _lastBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    super.initState();
  }

  @override
  void didChangePlatformBrightness() {
    final newBrightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;

    if (_lastBrightness == newBrightness) return;

    _lastBrightness = newBrightness;
    final cubit = context.read<AppThemeCubit>();

    if (cubit.state == ThemeMode.system) cubit.changeTheme(ThemeMode.system);

    super.didChangePlatformBrightness();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}
