import 'package:elevate_super_fitness/core/constants/app_colors.dart';
import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class CustomOrDivider extends StatelessWidget {
  const CustomOrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      key: const Key(WidgetsKeys.orDividerWidgetKey),
      spacing: 20.w,
      children: [
        const Expanded(child: SizedBox()),
        Expanded(child: Container(height: 1, color: AppColors.backGroundL[90])),
        Text(
          key: const Key(WidgetsKeys.orDividerTextKey),
          AppLocalizations.of(context).or,
          style: theme.textTheme.bodySmall?.copyWith(
            fontSize: 13.sp,
            color: AppColors.backGroundL[90],
          ),
        ),
        Expanded(child: Container(height: 1, color: AppColors.backGroundL[90])),
        const Expanded(child: SizedBox()),
      ],
    );
  }
}

