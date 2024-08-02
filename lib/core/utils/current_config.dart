import 'package:flutter/material.dart';

class CurrentConfig {
  final BuildContext context;

  CurrentConfig({required this.context});
  double get width => MediaQuery.sizeOf(context).width;
  double get height => MediaQuery.sizeOf(context).height;
}
