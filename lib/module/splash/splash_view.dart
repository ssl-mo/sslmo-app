import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sslmo/widget/index.dart';

class SplashView extends HookConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SMSafeColumn(
        top: true,
        bottom: true,
        children: const [
          Text("SPLASH VIEW"),
        ],
      ),
    );
  }
}
