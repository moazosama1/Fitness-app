import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class CustomExploreTabBarItem extends StatelessWidget {
  const CustomExploreTabBarItem({
    super.key,
    required this.isActive,
    this.title,
    this.isLoading = false,
  });
  final bool isActive;
  final bool isLoading;

  final String? title;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      key: const Key(WidgetsKeys.kExploreScreenTabBarItemKey),
      decoration: BoxDecoration(
        color: isActive == true
            ? theme.colorScheme.primary
            : Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0.sp),
        child: Center(
          child: Text(
            title ?? "",
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSecondary,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          ),
        ),
      ),
    );
  }
}

