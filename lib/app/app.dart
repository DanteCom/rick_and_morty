import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/app/domain/blocs/locations/locations_bloc.dart';
import 'package:rick_and_morty/app/ui/theme/theme.dart';
import 'package:rick_and_morty/app/router/app_router.dart';
import 'package:rick_and_morty/app/domain/blocs/blocs.dart';
import 'package:rick_and_morty/app/domain/cubits/cubits.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AppThemeCubit()),
        BlocProvider(create: (context) => CharactersBloc()),
        BlocProvider(create: (context) => LocationsBloc()),
      ],
      child: BlocBuilder<AppThemeCubit, ThemeMode>(
        builder: (context, mode) {
          final dark = AppTheme.dark;
          final light = AppTheme.light;

          return AppThemeListener(
            child: MaterialApp.router(
              themeMode: mode,
              theme: ThemeData(
                fontFamily: light.fontFamily,
                scaffoldBackgroundColor: light.color.background,
              ),
              darkTheme: ThemeData(
                fontFamily: dark.fontFamily,
                scaffoldBackgroundColor: dark.color.background,
              ),
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.routerConfig,
            ),
          );
        },
      ),
    );
  }
}
