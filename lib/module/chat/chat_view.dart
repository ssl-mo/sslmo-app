import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:sslmo/provider/app_provider.dart';
import 'package:sslmo/widget/index.dart';

class ChatView extends HookConsumerWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messageList = useState<List<String>>([]);
    final socket = useState<Socket?>(null);

    final textController = TextEditingController();

    useEffect(() {
      debugPrint("123123");

      try {
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
      } catch (e) {
        debugPrint(e.toString());
      }

      return () {
        socket.value?.dispose();
      };
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
          ],
        ),
      ),
    );
  }
}
