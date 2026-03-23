import 'dart:ui';

import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class CustomGlassShapeWidget extends StatelessWidget {
  final Widget child;
  final bool removePadding;

  const CustomGlassShapeWidget({
    super.key,
    required this.child,
    this.removePadding = false,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      key: const Key(WidgetsKeys.glassShapeWidgetKey),
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 34.6, sigmaY: 34.6),
        child: Container(
          width: double.infinity,
          padding: removePadding
              ? EdgeInsets.zero
              : const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          decoration: BoxDecoration(
            color: const Color(0xFF242424).withOpacity(0.1),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: removePadding
                ? EdgeInsets.zero
                : EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
            child: child,
          ),
        ),
      ),
    );
  }
}

