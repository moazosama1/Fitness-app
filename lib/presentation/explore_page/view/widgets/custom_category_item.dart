import 'package:elevate_super_fitness/core/constants/app_colors.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_events.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_view_model.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class CustomCategoryItem extends StatelessWidget {
  final bool lastItem;
  final MainHomeViewModel mainHomeViewModel;
  const CustomCategoryItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.lastItem,
    required this.mainHomeViewModel,
    this.onTap,
  });
  final String title, imagePath;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        if (lastItem) {
          context.read<MainHomeViewModel>().doIntent(
            OnBottomNavBarTappedEvent(index: 1),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          children: [
            Image.asset(
              imagePath,
              width: 32.w,
              height: 32.h,
              cacheWidth: 64,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 4.h),
            Text(
              title,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.backGroundL[90],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

