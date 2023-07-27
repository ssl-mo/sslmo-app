import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sslmo/asset/index.dart';
import 'package:sslmo/provider/router_provider.dart';
import 'package:rive/rive.dart';

class SplashView extends HookConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void onInit(Artboard art) {
      FlutterNativeSplash.remove();

      final controller = StateMachineController.fromArtboard(art, 'splash-state-machine') as StateMachineController;

      art.addController(controller);

      controller.isActiveChanged.addListener(() {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if (!controller.isActive) {
            SystemChrome.setEnabledSystemUIMode(
              SystemUiMode.manual,
              overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top],
            );

            context.go(AppRoute.onboard);
          }
        });
      });
    }

    return Scaffold(
      body: RiveAnimation.asset(
        RivFile.splash,
        fit: BoxFit.cover,
        onInit: onInit,
      ),
    );
  }
}
