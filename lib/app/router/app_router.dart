import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty/app/router/app_routes.dart';
import 'package:rick_and_morty/app/ui/screens/screens.dart';
import 'package:rick_and_morty/app/domain/blocs/blocs.dart';
import 'package:rick_and_morty/app/shell/app_shell_screen.dart';

class AppRouter {
  static final routerConfig = GoRouter(
    initialLocation: AppRoutes.splash.path,
    routes: [
      GoRoute(
        path: AppRoutes.splash.path,
        name: AppRoutes.splash.name,
        pageBuilder: (context, state) =>
            NoTransitionPage(child: SplashScreen()),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShellScreen(navigationShell: navigationShell),

        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.characters.path,
                name: AppRoutes.characters.name,
                builder: (context, state) => CharactersScreen(),
                routes: [
                  GoRoute(
                    path: AppRoutes.character.path,
                    name: AppRoutes.character.name,
                    builder: (context, state) {
                      final idStr = state.pathParameters['id'];
                      final id = int.tryParse(idStr ?? '') ?? 0;

                      return BlocProvider(
                        create: (context) => CharacterBloc(id: id),
                        child: CharacterScreen(id: id),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.locations.path,
                name: AppRoutes.locations.name,
                builder: (context, state) => LocationsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.episodes.path,
                name: AppRoutes.episodes.name,
                builder: (context, state) => EpisodesScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.settings.path,
                name: AppRoutes.settings.name,
                builder: (context, state) => SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
