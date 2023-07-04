import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sslmo/module/splash/splash_view.dart';

part 'router_provider.g.dart';

class AppRoute {
  AppRoute._();

  static const splash = '/splash';

  static const init = AppRoute.splash;

  static final routes = [
    GoRoute(
      path: AppRoute.splash,
      builder: (context, state) => const SplashView(),
    ),
  ];
}

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: AppRoute.init,
    routes: AppRoute.routes,
  );
}
