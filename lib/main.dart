import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quick_merchant_windows/app.dart';
import 'package:quick_merchant_windows/config/theme/app_theme.dart';
import 'package:quick_merchant_windows/features/auth/auth_screen.dart';
import 'package:window_manager/window_manager.dart';

final flutterLocalNotification = FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await initNotification();
  await EasyLocalization.ensureInitialized();
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    final flutterView = WidgetsBinding.instance.platformDispatcher.views.first;
    final logicalSize = flutterView.physicalSize / flutterView.devicePixelRatio;

    final WindowOptions windowOptions = WindowOptions(
      minimumSize: Size(logicalSize.height, logicalSize.height * 0.6),
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'QuickFood Merchant',
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      navigatorKey: App.navigatorKey,
      title: 'QuickFood Merchant',
      theme: AppTheme.lightTheme,
      home: const Stack(
        children: [
          AuthScreen(),
        ],
      ),
    );
  }
}

Future initNotification() async {
  const InitializationSettings initializationSettings = InitializationSettings(
    windows: WindowsInitializationSettings(
      appName: 'QuickFood Merchant',
      appUserModelId: 'esmm.quickfood.merchant.1.0.0',
      guid: '0a0bd023-f296-4623-831d-c9af0a73c802',
    ),
  );
  await flutterLocalNotification.initialize(initializationSettings);
}
