import 'package:flutter/material.dart';
import 'package:quick_merchant_windows/core/assets/images.dart';
import 'package:quick_merchant_windows/core/utils/current_config.dart';
import 'package:quick_merchant_windows/core/widgets/dialog/base_dialog.dart';

class App {
  App._();
  static final navigatorKey = GlobalKey<NavigatorState>();
  static BuildContext? _context;
  static set context(BuildContext con) => _context = con;
  static BuildContext get context => _context!;
  static CurrentConfig currentConfig = CurrentConfig(context: context);
  static double get screenwidth => currentConfig.width;
  static double get screenHeight => currentConfig.height;
  static TextTheme get textTheme => Theme.of(context).textTheme;
  static ColorScheme get colorSchema => Theme.of(context).colorScheme;
  static final _dialogManager = DialogManager(context);
  static final materialBannerManager = MaterialBannerManager(context);

  //ui
  static bool isLoadingShowing = false;
  static void showLoadingOverlay() async {
    isLoadingShowing = true;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    ).then((_) {
      isLoadingShowing = false;
    });
  }

  static void showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        behavior: SnackBarBehavior.floating,
        content: Text('Loading...'),
        margin: EdgeInsets.only(top: 0, left: 0, right: 0),
        showCloseIcon: true,
      ),
    );
  }

  static void hideLoadingOverlay() {
    if (isLoadingShowing) {
      Navigator.of(context).pop();
    }
  }

  static void showCustomDialog({
    final DialogType type = DialogType.neutral,
    required final String? title,
    required final String message,
    final String? buttonText,
    required final VoidCallback? onActionClick,
    required final VoidCallback? onCancelClick,
    final bool showCancelButton = true,
    final double? width,
    final double? height,
  }) {
    _dialogManager.showCustomDialog(
      type: type,
      title: title,
      message: message,
      buttonText: buttonText,
      onActionClick: onActionClick,
      onCancelClick: onCancelClick,
      showCancelButton: showCancelButton,
      width: width,
      height: height,
    );
  }

  // static void showSnackbar(String message) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(
  //       content: Text(message),
  //     ),
  //   );
  // }

  //colors
  static final containerColor = Colors.grey.shade100;
}

class MaterialBannerManager {
  final BuildContext context;

  MaterialBannerManager(this.context);
  late final overlay = Overlay.of(context);
  late final _bannerStack = <String>[];

  void showBanner({
    required String title,
    required String message,
  }) {
    late final OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0,
        left: 0.0,
        right: 0.0,
        child: MaterialBanner(
            dividerColor: Colors.transparent,
            leading: Image.asset(
              Images.shopLogo,
              width: 50,
              height: 50,
            ),
            content: Column(
              children: [
                Text(DateTime.now().toString()),
                Text(message),
              ],
            ),
            actions: [
              const SizedBox.shrink(),
              ElevatedButton(
                onPressed: () {
                  overlayEntry.remove();
                  _bannerStack.removeLast();
                },
                child: const Text('Close'),
              ),
            ]),
      ),
    );
    overlay.insert(overlayEntry);
    _bannerStack.add(title);
  }
}

class DialogManager {
  final BuildContext context;
  final _diaStack = <DialogType>[];

  DialogManager(this.context);

  void showCustomDialog({
    required final DialogType type,
    required final String? title,
    required final String message,
    required final String? buttonText,
    required final VoidCallback? onActionClick,
    required final VoidCallback? onCancelClick,
    required final bool showCancelButton,
    required final double? width,
    required final double? height,
  }) {
    _diaStack.add(DialogType.warning);
    showDialog(
      barrierColor: Colors.black38,
      context: context,
      builder: (diaContext) {
        return BaseDialog(
          type: type,
          message: message,
          title: title,
          buttonText: buttonText,
          onActionClick: onActionClick,
          onCancelClick: onCancelClick,
          showCancelButton: showCancelButton,
          width: width,
          height: height,
        );
      },
    ).then((_) {
      _diaStack.removeLast();
    });
  }

  void hideDialog() {
    if (_diaStack.isNotEmpty) {
      Navigator.pop(context);
    }
  }

  void hideAllDialog() {
    while (_diaStack.isNotEmpty) {
      Navigator.pop(context);
    }
  }
}
