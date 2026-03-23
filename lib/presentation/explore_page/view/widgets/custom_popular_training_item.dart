import 'dart:ui';

import 'package:elevate_super_fitness/core/constants/app_images.dart';
import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class CustomPopularTrainingItem extends StatelessWidget {
  const CustomPopularTrainingItem({super.key, this.width, this.height});

  final int? width, height;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return ClipRRect(
      key: const Key(WidgetsKeys.kExploreScreenPopularTrainingItemKey),
      borderRadius: BorderRadius.circular(20.r),
      child: AspectRatio(
        aspectRatio: (width != null && height != null)
            ? width! / height!
            : 200 / 176,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppImages.authBg),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "exercises that strengthen your Chest",
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 34.6, sigmaY: 34.6),
                        child: Container(
                          color: const Color(0xFF242424).withOpacity(0.1),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 8.h,
                            ),
                            child: Center(
                              child: Text(
                                "Push-up",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSecondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.r),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 34.6, sigmaY: 34.6),
                        child: Container(
                          color: const Color(0xFF242424).withOpacity(0.1),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 4.w,
                              vertical: 8.h,
                            ),
                            child: Center(
                              child: Text(
                                "Push-up",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

