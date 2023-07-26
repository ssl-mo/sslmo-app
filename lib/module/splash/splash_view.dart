import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:sslmo/provider/app_provider.dart';
import 'package:sslmo/widget/index.dart';

class SplashView extends HookConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageList = useState<List<String>>([]);
    final socket = useState<Socket?>(null);

    final textController = TextEditingController();

    useEffect(() {
      final socketIO = io(
        ref.read(chatUrlProvider),
        OptionBuilder().setTransports(['websocket']).build(),
      );

      socket.value = socketIO;

      socketIO.connect();
      socketIO.onConnect((_) {
        debugPrint('Connection established');
      });
      socketIO.onDisconnect((_) => debugPrint('Connection Disconnection'));
      socketIO.onConnectError((err) => debugPrint(err));
      socketIO.onError((err) => debugPrint(err));

      socketIO.on('m', (message) {
        debugPrint(message.toString());
        messageList.value = [...messageList.value, message.toString()];
      });
      return null;
    }, []);

    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Scaffold(
        body: SMSafeColumn(
          top: true,
          bottom: true,
          children: [
            Expanded(
              child: SMSingleScroll(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...messageList.value
                        .map(
                          (message) => Text(message),
                        )
                        .toList(),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: textController,
                  ),
                ),
                InkWell(
                  onTap: () {
                    socket.value?.emit(
                      "message",
                      [
                        textController.text,
                      ],
                    );

                    textController.text = "";
                  },
                  child: Container(
                    width: 50.w,
                    alignment: Alignment.center,
                    child: const Text("Send"),
                  ),
                ),
              ],
            ),
            InkWell(
              child: const Text('zkzkdh fhrmdls'),
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
            ),
          ],
        ),
      ),
    );
  }
}
