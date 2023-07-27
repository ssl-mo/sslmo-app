import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:sslmo/asset/index.dart';
import 'package:sslmo/style/index.dart';
import 'package:sslmo/util/extension.dart';
import 'package:sslmo/widget/index.dart';

class SignInView extends HookConsumerWidget {
  const SignInView({super.key});

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
            SMHeight(166),
            const SMSvgImage(
              SvgImage.logoBasic,
              height: 128,
              fit: BoxFit.fitHeight,
            ),
            const Spacer(),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: InkWell(
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
                  PngImage.kakaoLogin,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SMHeight(16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: InkWell(
                onTap: () {},
                child: const SMPngImage(
                  PngImage.naverLogin,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SMHeight(16),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: InkWell(
                onTap: () {},
                child: const SMPngImage(
                  PngImage.appleLogin,
                  width: double.infinity,
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            SMHeight(16),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              child: Text(
                "본인 인증으로 로그인",
                style: Pretendard.semiBold.set(
                  size: 17,
                  height: 21,
                  color: Primary.dark,
                  letter: -0.4,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SMHeight(16),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              child: Text(
                "비회원 둘러보기",
                style: Pretendard.regular.set(
                  size: 14,
                  height: 20,
                  color: Secondary.bg05,
                ),
              ),
            ),
            SMHeight(27),
          ],
        ),
      ),
    );
  }
}
