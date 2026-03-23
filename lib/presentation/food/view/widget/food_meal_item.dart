import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

import '../../../../core/constants/app_colors.dart';

class FoodMealItem extends StatelessWidget {
  final String mealImage;
  final String mealName;
  final VoidCallback onTap;

  const FoodMealItem({
    super.key,
    required this.mealImage,
    required this.mealName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.r),
              child: CustomCachedNetworkImage(
                imageUrl: mealImage,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.center,
                  colors: [
                    AppColors.black.withValues(alpha: 0.55),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.all(8.sp),
              child: Text(
                mealName,
                style: context.bodyMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

