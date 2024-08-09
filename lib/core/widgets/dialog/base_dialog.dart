// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:quick_merchant_windows/app.dart';
import 'package:quick_merchant_windows/config/constants/app_colors.dart';
import 'package:quick_merchant_windows/core/utils/current_config.dart';

import '../../locale/my_locale.dart';

enum DialogType {
  neutral,
  success,
  warning,
  error;
}

class BaseDialog extends StatelessWidget {
  final DialogType type;
  final String? title;
  final String message;
  final String? buttonText;
  final VoidCallback? onActionClick;
  final VoidCallback? onCancelClick;
  final bool showCancelButton;
  final double? width;
  final double? height;
  const BaseDialog({
    Key? key,
    required this.type,
    this.title,
    required this.message,
    this.buttonText,
    this.onActionClick,
    this.onCancelClick,
    this.showCancelButton = true,
    this.width,
    this.height,
  }) : super(key: key);
  Color get getColor => switch (type) {
        DialogType.success => Colors.green,
        DialogType.warning => AppColors.appPrimaryColor,
        DialogType.error => Colors.red,
        DialogType.neutral => Colors.blueGrey,
      };
  IconData get getIcon => switch (type) {
        DialogType.success => Icons.check_rounded,
        DialogType.warning => Icons.info_rounded,
        DialogType.error => Icons.close_rounded,
        DialogType.neutral => Icons.info_rounded,
      };

  String get getButtonText => switch (type) {
        DialogType.success => MyLocale.ok,
        DialogType.warning => MyLocale.continued,
        DialogType.error => MyLocale.retry,
        DialogType.neutral => MyLocale.ok,
      };

  @override
  Widget build(BuildContext context) {
    final config = CurrentConfig(context: context);
    final diaWidth = width ?? config.height * 0.5;
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      contentPadding: EdgeInsets.zero,
      content: SizedBox(
        width: diaWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: getColor.withOpacity(0.1),
              ),
              child: Row(
                children: [
                  // Image.asset(
                  //   Images.logo,
                  //   width: 35,
                  //   height: 35,
                  // ),
                  const SizedBox(width: 12),
                  Expanded(child: Text(MyLocale.appName)),
                  const CloseButton()
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                crossAxisAlignment: title == null
                    ? CrossAxisAlignment.center
                    : CrossAxisAlignment.start,
                children: [
                  Icon(
                    getIcon,
                    size: 35,
                    color: getColor,
                  ),
                  const SizedBox(width: 12),
                  title == null
                      ? Text(
                          message,
                          style: TextStyle(color: getColor),
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title!,
                              style: App.textTheme.titleMedium
                                  ?.copyWith(color: getColor),
                            ),
                            Text(message),
                          ],
                        ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 4),
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              decoration: BoxDecoration(
                color: getColor.withOpacity(0.03),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (showCancelButton)
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: getColor,
                              width: 0.7,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            )),
                        onPressed: () {
                          Navigator.pop(context);
                          onCancelClick?.call();
                        },
                        child: Text(MyLocale.cancel,
                            style: TextStyle(color: getColor))),
                  const SizedBox(width: 7),
                  FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onActionClick?.call();
                    },
                    style: FilledButton.styleFrom(backgroundColor: getColor),
                    child: Text(getButtonText),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
