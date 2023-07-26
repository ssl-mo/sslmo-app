import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sslmo/enum/app_mode.dart';

part 'app_provider.g.dart';

@riverpod
AppMode appMode(AppModeRef ref) {
  return throw UnimplementedError();
}

@riverpod
String apiUrl(ApiUrlRef ref) {
  final appMode = ref.watch(appModeProvider);

  switch (appMode) {
    case AppMode.dev:
      return dotenv.get("DEV_API_URL");
    case AppMode.prod:
      return dotenv.get("PROD_API_URL");
  }
}

@riverpod
String apiKey(ApiKeyRef ref) {
  final appMode = ref.watch(appModeProvider);

  switch (appMode) {
    case AppMode.dev:
      return dotenv.get("DEV_API_KEY");
    case AppMode.prod:
      return dotenv.get("PROD_API_KEY");
  }
}

@riverpod
String chatUrl(ChatUrlRef ref) {
  final appMode = ref.watch(appModeProvider);

  switch (appMode) {
    case AppMode.dev:
      return dotenv.get("DEV_CHAT_URL");
    case AppMode.prod:
      return dotenv.get("PROD_CHAT_URL");
  }
}

@riverpod
String serverStatusKey(ServerStatusKeyRef ref) {
  final appMode = ref.watch(appModeProvider);

  switch (appMode) {
    case AppMode.dev:
      return "DEV_SERVER_STATUS";
    case AppMode.prod:
      return "PROD_SERVER_STATUS";
  }
}

@riverpod
String appStatusKey(AppStatusKeyRef ref) {
  final appMode = ref.watch(appModeProvider);

  switch (appMode) {
    case AppMode.dev:
      return "DEV_APP_STATUS";
    case AppMode.prod:
      return "PROD_APP_STATUS";
  }
}

@riverpod
String kakaoNativeKey(KakaoNativeKeyRef ref) {
  final appMode = ref.watch(appModeProvider);

  switch (appMode) {
    case AppMode.dev:
      return dotenv.get("DEV_KAKAO_NATIVE_KEY");
    case AppMode.prod:
      return dotenv.get("PROD_KAKAO_NATIVE_KEY");
  }
}

@riverpod
String kakaoJSKey(KakaoJSKeyRef ref) {
  final appMode = ref.watch(appModeProvider);

  switch (appMode) {
    case AppMode.dev:
      return dotenv.get("DEV_KAKAO_JS_KEY");
    case AppMode.prod:
      return dotenv.get("PROD_KAKAO_JS_KEY");
  }
}
