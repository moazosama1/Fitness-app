import 'package:elevate_super_fitness/core/constants/app_images.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class SplashViewBody extends StatelessWidget {
  const SplashViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              child: Container(
                width: 243.w,
                height: 151.h,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(AppImages.logoImage),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ],
        );
  }
}
