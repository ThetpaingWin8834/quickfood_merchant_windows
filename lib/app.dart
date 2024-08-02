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
  static ColorScheme get colorSchema => Theme.of(context).colorScheme;

  //ui
  static bool isLoadingShowing = false;
  static void showLoadingOverlay() async {
    isLoadingShowing = true;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
        child: CircularProgressIndicator(),
      ),
    ).then((_) {
      isLoadingShowing = false;
    });
  }

  static void hideLoadingOverlay() {
    if (isLoadingShowing) {
      Navigator.of(context).pop();
    }
  }

  static void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  //colors
  static final containerColor = Colors.grey.shade100;
}
