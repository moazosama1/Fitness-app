import 'dart:ui';
import 'package:elevate_super_fitness/core/constants/app_images.dart';
import 'package:flutter/material.dart';

class CustomFoodBg extends StatelessWidget {
  final Widget child;

  const CustomFoodBg({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
            tileMode: TileMode.clamp,
          ),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ResizeImage(
                  AssetImage(AppImages.foodBg),
                  width: 828,
                  policy: ResizeImagePolicy.fit,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),

        Container(color: Colors.black.withOpacity(0.3)),
        child,
      ],
    );
  }
}
