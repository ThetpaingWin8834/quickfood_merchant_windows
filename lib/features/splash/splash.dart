// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:quick_merchant_windows/app.dart';

import 'package:quick_merchant_windows/core/assets/images.dart';
import 'package:quick_merchant_windows/core/widgets/dialog/base_dialog.dart';

class SplashWidget extends StatefulWidget {
  final VoidCallback onSplashAnimationFinished;
  const SplashWidget({
    super.key,
    required this.onSplashAnimationFinished,
  });

  @override
  State<SplashWidget> createState() => _SplashWidgetState();
}

class _SplashWidgetState extends State<SplashWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..forward()
        ..addStatusListener(
          (status) {
            if (status == AnimationStatus.completed) {
              widget.onSplashAnimationFinished();
            }
          },
        );
  late final Animation<double> _animation =
      CurvedAnimation(parent: _controller, curve: Curves.elasticOut);

  @override
  Widget build(BuildContext context) {
    App.context = context;

    return Scaffold(
      body: Center(
        child: ScaleTransition(
          scale: _animation,
          child: InkWell(
            onTap: () {
              App.showCustomDialog(
                  title: 'Title',
                  message: "Hello world!",
                  onActionClick: () {},
                  onCancelClick: () {},
                  type: DialogType.neutral);
              // App.showSnackbar();
            },
            child: Image.asset(Images.shopLogo),
          ),
        ),
      ),
    );
  }
}
