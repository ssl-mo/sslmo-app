import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sslmo/module/main/main_view.dart';
import 'package:sslmo/module/onboard/sign_in/sign_in_view.dart';
import 'package:sslmo/module/onboard/sign_up/sgin_up_view.dart';
import 'package:sslmo/module/onboard/onboard_view.dart';
import 'package:sslmo/module/splash/splash_view.dart';

part 'router_provider.g.dart';

class AppRoute {
  AppRoute._();

  static const init = AppRoute.splash;

  static const splash = '/splash';

  static const onboard = '/onboard';
  static const signIn = '$onboard/sign/in';
  static const signUp = '$onboard/sign/up';
  static const passwordReset = '$onboard/password/reset';

  static const main = '/main';

  static final routes = [
    GoRoute(
      path: AppRoute.splash,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: AppRoute.onboard,
      builder: (context, state) => const OnboardView(),
      routes: [
        GoRoute(
          path: AppRoute.signIn.replaceAll("$onboard/", ""),
          builder: (context, state) => const SignInView(),
        ),
        GoRoute(
          path: AppRoute.signUp.replaceAll("$onboard/", ""),
          builder: (context, state) => const SignUpView(),
        ),
      ],
    ),
    GoRoute(
      path: AppRoute.main,
      builder: (context, state) => const MainView(),
    )
  ];
}

@riverpod
GoRouter router(RouterRef ref) {
  return GoRouter(
    initialLocation: AppRoute.init,
    routes: AppRoute.routes,
  );
}
