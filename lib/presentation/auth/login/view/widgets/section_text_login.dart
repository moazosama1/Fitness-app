import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class SectionTextLogin extends StatelessWidget {
  const SectionTextLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Column(
            spacing: 4.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                key: const Key(WidgetsKeys.kLoginScreenHeyThereText),
                local.heyThere,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: theme.colorScheme.onSecondary,
                ),
              ),
              Text(
                key: const Key(WidgetsKeys.kLoginScreenWelcomeBackText),
                local.welcomeBack,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.colorScheme.onSecondary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

