import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sslmo/util/extension.dart';
import 'package:sslmo/widget/index.dart';

class SearchView extends HookConsumerWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: () => context.unFocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("지역 설정"),
        ),
        body: SMSafeColumn(
          top: true,
          bottom: true,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SMHeight(50),
            Container(
              height: 50,
              margin: const EdgeInsets.all(10),
              padding: const EdgeInsets.only(
                top: 10,
                left: 10,
                right: 10,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.black12,
                ),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "지역명(동/읍/면)으로 찾기 (ex. 서초동)",
                  hintStyle: TextStyle(
                    color: Colors.black26,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            SMHeight(50),
            const Text(
              "지역은 앱 내에서 언제든지\n재설정 할 수 있습니다.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
