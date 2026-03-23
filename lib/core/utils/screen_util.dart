import 'package:flutter/material.dart';

class ScreenUtilInit extends StatelessWidget {
  final Size designSize;
  final bool minTextAdapt;
  final bool splitScreenMode;
  final Widget? child;
  final Widget Function(BuildContext context, Widget? child) builder;

  const ScreenUtilInit({
    super.key,
    required this.designSize,
    required this.minTextAdapt,
    required this.splitScreenMode,
    required this.builder,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return builder(context, child);
  }
}

extension ScreenUnitNumExt on num {
  double get w => toDouble();
  double get h => toDouble();
  double get sp => toDouble();
  double get r => toDouble();
}
