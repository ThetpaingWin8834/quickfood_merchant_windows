import 'package:flutter/material.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constranit) {
      final isDesktopView = constranit.minWidth > constranit.minHeight;
      return isDesktopView ? const DesktopDashBoard() : const MobileDashBoard();
    });
  }
}

class DesktopDashBoard extends StatelessWidget {
  const DesktopDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
    );
  }
}

class MobileDashBoard extends StatelessWidget {
  const MobileDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan,
    );
  }
}
