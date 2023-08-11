import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sslmo/module/chat/chat_view.dart';
import 'package:sslmo/module/onboard_view.dart';
import 'package:sslmo/module/search/search_view.dart';
import 'package:sslmo/module/sign_in/sign_in_view.dart';
import 'package:sslmo/module/splash/splash_view.dart';

part 'router_provider.g.dart';

class AppRoute {
  AppRoute._();

  static const splash = '/splash';

  static const onboard = '/onboard';
  static const signIn = '$onboard/sign/in';
  static const chat = '$onboard/chat';
  static const search = '$onboard/search';

  static const init = AppRoute.splash;

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
          path: AppRoute.chat.replaceAll("$onboard/", ""),
          builder: (context, state) => const ChatView(),
        ),
        GoRoute(
          path: AppRoute.search.replaceAll("$onboard/", ""),
          builder: (context, state) => const SearchView(),
        ),
      ],
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
