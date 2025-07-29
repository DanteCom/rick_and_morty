class AppRoutes {
  final String path;
  final String name;

  static const splash = AppRoutes._(path: '/splash', name: 'splash');
  static const settings = AppRoutes._(path: '/settings', name: 'settings');
  static const favorites = AppRoutes._(path: '/favorites', name: 'favorites');
  static const locations = AppRoutes._(path: '/locations', name: 'locations');
  static const characters = AppRoutes._(
    path: '/characters',
    name: 'characters',
  );
  static const character = AppRoutes._(
    path: '/character/:id',
    name: 'character',
  );

  const AppRoutes._({required this.path, required this.name});
}
