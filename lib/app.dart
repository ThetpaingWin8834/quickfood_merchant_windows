import 'package:flutter/material.dart';
import 'package:quick_merchant_windows/core/utils/current_config.dart';

class App {
  App._();
  static final navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext get context => navigatorKey.currentState!.context;
  static CurrentConfig currentConfig = CurrentConfig(context: context);
  static double get screenwidth => currentConfig.width;
  static double get screenHeight => currentConfig.height;
  static TextTheme get textTheme => Theme.of(context).textTheme;

  //colors
  static final containerColor = Colors.grey.shade100;
}
