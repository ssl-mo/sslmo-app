import 'package:flutter/services.dart';
import 'package:sslmo/enum/app_mode.dart';

Future<AppMode> getAppMode() async {
  final flavor = await const MethodChannel('flavor').invokeMethod<String>('getFlavor') ?? 'prod';

  return flavor.toAppMode();
}
