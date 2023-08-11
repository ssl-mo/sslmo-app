import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sslmo/provider/router_provider.dart';
import 'package:sslmo/util/extension.dart';
import 'package:sslmo/widget/index.dart';

class OnboardView extends HookConsumerWidget {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => context.unFocus(),
      child: Scaffold(
        body: SMSafeColumn(
          top: true,
          bottom: true,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () => context.go(AppRoute.signIn),
              child: const Text("로그인 이동"),
            ),
            InkWell(
              onTap: () => context.go(AppRoute.chat),
              child: const Text("채팅 이동"),
            ),
            InkWell(
              onTap: () => context.go(AppRoute.search),
              child: const Text("검색창 이동"),
            ),
          ],
        ),
      ),
    );
  }
}
