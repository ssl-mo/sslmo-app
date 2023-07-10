import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sslmo/enum/app_mode.dart';

part 'app_provider.g.dart';

@riverpod
AppMode appMode(AppModeRef ref) {
  return throw UnimplementedError();
}

@riverpod
String chatUrl(ChatUrlRef ref) {
  return dotenv.get("CHAT_URL");
}

@riverpod
String baseUrl(BaseUrlRef ref) {
  final appMode = ref.watch(appModeProvider);

  switch (appMode) {
    case AppMode.dev:
      return dotenv.get("DEV_BASE_URL");
    case AppMode.prod:
      return dotenv.get("PROD_BASE_URL");
  }
}

@riverpod
String appKey(AppKeyRef ref) {
  final appMode = ref.watch(appModeProvider);

  switch (appMode) {
    case AppMode.dev:
      return dotenv.get("DEV_APP_KEY");
    case AppMode.prod:
      return dotenv.get("PROD_APP_KEY");
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
