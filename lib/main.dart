import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sslmo/constant/storage_key.dart';
import 'package:sslmo/provider/router_provider.dart';
import 'package:sslmo/provider/storage_provider.dart';
import 'package:sslmo/util/logger.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 가로 모드 세팅
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // .env 가져옴
  await dotenv.load(fileName: ".env");

  const secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  final localStorage = await SharedPreferences.getInstance();
  if (localStorage.getBool(StorageKey.isFirstLaunch) ?? true) {
    await secureStorage.deleteAll();
    await localStorage.setBool(StorageKey.isFirstLaunch, false);
  }

  return runApp(
    ProviderScope(
      overrides: [
        secureStorageProvider.overrideWithValue(secureStorage),
        localStorageProvider.overrideWithValue(localStorage),
      ],
      observers: [
        ProviderLogger(),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    // 반응형 화면을 위해 ScreenUtilInit 세팅
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (BuildContext context, Widget? child) {
        return GlobalLoaderOverlay(
          useDefaultLoading: false,
          overlayColor: Colors.transparent,
          overlayWidget: Center(
            child: Container(
              height: 82.r,
              width: 82.r,
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.3), borderRadius: BorderRadius.circular(12.r)),
              child: Center(
                child: CupertinoActivityIndicator(
                  color: Colors.white,
                  radius: 15.r,
                ),
              ),
            ),
          ),
          child: MaterialApp.router(
            theme: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              scaffoldBackgroundColor: Colors.white,
            ),
            routerConfig: router,
            debugShowCheckedModeBanner: false,
            builder: (context, widget) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget ?? const SizedBox.shrink(),
              );
            },
          ),
        );
      },
    );
  }
}
