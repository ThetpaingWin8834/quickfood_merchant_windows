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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      restorationScopeId: 'Merchant',
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      navigatorKey: App.navigatorKey,
      title: 'Flutter Demo',
      theme: AppTheme.lightTheme,
      home: const AuthScreen(),
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
//https://hr.esoftmm.com/#/notification/specific
