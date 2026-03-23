import 'dart:ui';
import 'package:elevate_super_fitness/core/constants/app_images.dart';
import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';
import 'package:flutter_svg/svg.dart';

class CustomAuthBg extends StatelessWidget {
  const CustomAuthBg({super.key, this.arrowIconPath, required this.child});
  final String? arrowIconPath;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Stack(
      key: const Key(WidgetsKeys.authBgKey),
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
                image: AssetImage(AppImages.authBg),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 46.h, width: double.infinity),
            Stack(
              alignment: Alignment.center,
              children: [
                if (arrowIconPath != null)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: SvgPicture.asset(arrowIconPath!),
                      ),
                    ),
                  ),
                Image.asset(AppImages.logoImage, width: 70.w, height: 48.h),
              ],
            ),
            child,
          ],
        ),
      ],
    );
  }
}

