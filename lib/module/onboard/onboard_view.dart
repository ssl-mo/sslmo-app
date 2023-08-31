import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sslmo/asset/index.dart';
import 'package:sslmo/module/onboard/onboard_provider.dart';
import 'package:sslmo/provider/router_provider.dart';
import 'package:sslmo/style/index.dart';
import 'package:sslmo/util/extension.dart';
import 'package:sslmo/widget/index.dart';

class OnboardView extends HookConsumerWidget {
  const OnboardView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(emailProvider);

    return GestureDetector(
      onTap: () => context.unFocus(),
      child: Scaffold(
        body: SMSingleScroll(
          child: SMSafeColumn(
            top: true,
            bottom: true,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SMHeight(137),
              const SMSvgImage(
                SvgImage.logoBasic,
                height: 128,
                fit: BoxFit.fitHeight,
              ),
              SMHeight(20),
              Text(
                "쓸수록 모이는 나눔을 함께 해요!",
                textAlign: TextAlign.center,
                style: Pretendard.semiBold.set(
                  size: 17,
                  height: 24,
                  color: PrimaryColors.accent,
                ),
              ),
              SMHeight(40),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SMInput(
                  hintText: "이메일을 입력해 주세요.",
                  message: ref.watch(emailMessageProvider),
                  messageType: ref.watch(emailMessageTypeProvider),
                  onChanged: (value) => ref.read(emailProvider.notifier).update(value),
                ),
              ),
              SMHeight(16),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: SMButton(
                  "시작하기",
                  enabled: ref.watch(signInEnabledProvider),
                ),
              ),
              SMHeight(32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () async {
                      if (await isKakaoTalkInstalled()) {
                        try {
                          await UserApi.instance.loginWithKakaoTalk();
                          debugPrint('카카오톡으로 로그인 성공');
                        } catch (error) {
                          debugPrint('카카오톡으로 로그인 실패 $error');

                          // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
                          // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
                          if (error is PlatformException && error.code == 'CANCELED') {
                            return;
                          }
                          // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
                          try {
                            await UserApi.instance.loginWithKakaoAccount();
                            debugPrint('카카오계정으로 로그인 성공');
                          } catch (error) {
                            debugPrint('카카오계정으로 로그인 실패 $error');
                          }
                        }
                      } else {
                        try {
                          await UserApi.instance.loginWithKakaoAccount();
                          debugPrint('카카오계정으로 로그인 성공');
                        } catch (error) {
                          debugPrint('카카오계정으로 로그인 실패 $error');
                        }
                      }
                    },
                    child: const SMPngImage(
                      PngImage.kakao,
                      size: 46,
                    ),
                  ),
                  SMWidth(16),
                  InkWell(
                    onTap: () async {
                      // NaverLoginResult res = await FlutterNaverLogin.logIn();
                    },
                    child: const SMPngImage(
                      PngImage.naver,
                      size: 46,
                    ),
                  ),
                  SMWidth(16),
                  InkWell(
                    onTap: () async {
                      // NaverLoginResult res = await FlutterNaverLogin.logIn();
                    },
                    child: const SMPngImage(
                      PngImage.apple,
                      size: 46,
                    ),
                  ),
                ],
              ),
              SMHeight(24),
              Center(
                child: InkWell(
                  onTap: () => context.go(AppRoute.main),
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
                    child: Text(
                      "비회원 둘러보기",
                      style: Pretendard.semiBold.set(
                        size: 17,
                        height: 21,
                        color: SecondaryColors.bg05,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
              SMHeight(20),
            ],
          ),
        ),
      ),
    );
  }
}
