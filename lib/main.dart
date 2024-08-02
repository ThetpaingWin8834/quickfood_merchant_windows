import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:quick_merchant_windows/features/web/web_screen.dart';
import 'package:window_manager/window_manager.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await initNotification();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ExampleBrowser(),
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

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}
//https://hr.esoftmm.com/#/notification/specific
