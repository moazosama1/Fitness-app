import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class CustomTitlePage extends StatelessWidget {
  const CustomTitlePage({super.key});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 4.h,
        children: [
          Text(
            key: const Key(WidgetsKeys.kChangePasswordScreenTitleTextKey),
            local.makeSureIts8CharactersOrMore,
            style: theme.textTheme.headlineMedium?.copyWith(
              color: theme.colorScheme.onSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
          Text(
            key: const Key(WidgetsKeys.kChangePasswordScreenSubtitleTextKey),
            local.createNewPassword,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSecondary,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

