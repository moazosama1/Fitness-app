import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomProfileItemWidget extends StatelessWidget {
  const CustomProfileItemWidget({
    super.key,
    required this.title,
    required this.imagePath,
    this.widgetSecondIcon,
    this.onTap,
  });
  final String title, imagePath;
  final Widget? widgetSecondIcon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Row(
          key: const Key(WidgetsKeys.kProfileScreenCustomRowItemKey),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  imagePath,
                  color: theme.colorScheme.primary,
                  width: 20.w,
                  height: 20.h,
                ),
                SizedBox(width: 16.w),
                Text(
                  title,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                ),
              ],
            ),
            if (widgetSecondIcon == null)
              GestureDetector(
                onTap: onTap,
                child: Transform.scale(
                  scale: -1,
                  child: Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: theme.colorScheme.primary,
                    size: 20.sp,
                  ),
                ),
              ),
            if (widgetSecondIcon != null) widgetSecondIcon!,
          ],
        ),
        const Divider(color: Color(0xff2D2D2D), height: 8, endIndent: 0),
      ],
    );
  }
}

