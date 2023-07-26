import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sslmo/constant/storage_key.dart';
import 'package:sslmo/firebase_options.dart';
import 'package:sslmo/provider/app_provider.dart';
import 'package:sslmo/provider/router_provider.dart';
import 'package:sslmo/provider/storage_provider.dart';
import 'package:sslmo/util/logger.dart';
import 'package:sslmo/util/mode.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 가로 모드 세팅
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // .env 가져옴
  await dotenv.load(fileName: ".env");

  // 에러 시 FirebaseCrashlytics 로 에러 값 보냄
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  await Firebase.initializeApp(
    options: await currentPlatform(),
  );

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
        appModeProvider.overrideWithValue(await getAppMode()),
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

    KakaoSdk.init(
      nativeAppKey: ref.watch(kakaoNativeKeyProvider),
      javaScriptAppKey: ref.watch(kakaoJSKeyProvider),
    );

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
