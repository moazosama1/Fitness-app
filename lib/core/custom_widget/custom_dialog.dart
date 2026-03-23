import 'dart:ui';

import 'package:dashed_circular_progress_bar/dashed_circular_progress_bar.dart';
import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';
import '../constants/app_colors.dart';

class CustomDialog {
  final BuildContext context;

  String? title, message, positiveText, negativeText;

  VoidCallback? positiveOnClick, negativeOnClick;

  CustomDialog.fitnessLoading({
    required this.context,
    this.message,
    bool cancelable = false,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Center(
          key: const Key(WidgetsKeys.kCustomDialogFitnessLoadingKey),
          child: SizedBox(
            width: 120.w,
            height: 120.h,
            child: Center(
              child: DashedCircularProgressBar.aspectRatio(
                aspectRatio: 1,
                progress: 100,
                maxProgress: 100,
                corners: StrokeCap.square,
                foregroundColor: AppColors.backGroundL[90]!,
                backgroundColor: Colors.transparent,
                foregroundStrokeWidth: 10,
                backgroundStrokeWidth: 10,
                animation: true,
                startAngle: 200,
              ),
            ),
          ),
        );
      },
    );
  }

  CustomDialog.fitnessPositiveButton({
    required this.context,
    this.title,
    this.message,
    this.positiveText,
    this.positiveOnClick,
    bool cancelable = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: cancelable,
      builder: (ctx) {
        return Center(
          key: const Key(WidgetsKeys.kCustomDialogFitnessPositiveButtonKey),
          child: Padding(
            padding: EdgeInsets.all(24.sp),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: EdgeInsets.all(16.sp),
                  decoration: BoxDecoration(
                    color: const Color(0xFF242424).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 24.h,
                    children: [
                      Text(
                        message ?? "",
                        textAlign: TextAlign.center,
                        style: Theme.of(ctx).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Expanded(child: SizedBox()),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),
                              onPressed: () {
                                if (positiveOnClick != null) {
                                  positiveOnClick!();
                                } else {
                                  Navigator.of(ctx).pop();
                                }
                              },
                              child: Text(
                                negativeText ?? AppLocalizations.of(ctx).ok,
                                style: Theme.of(ctx).textTheme.headlineSmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSecondary,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  CustomDialog.fitnessPositiveAndNegativeButton({
    required this.context,
    String? message,
    String? positiveText,
    String? negativeText,
    VoidCallback? positiveOnClick,
    VoidCallback? negativeOnClick,
    bool cancelable = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: cancelable,
      builder: (ctx) {
        return Center(
          key: const Key(
            WidgetsKeys.kCustomDialogFitnessPositiveAndNegativeButtonKey,
          ),
          child: Padding(
            padding: EdgeInsets.all(24.sp),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                child: Container(
                  padding: EdgeInsets.all(16.sp),
                  decoration: BoxDecoration(
                    color: const Color(0xFF242424).withOpacity(0.5),
                    borderRadius: BorderRadius.circular(24.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    spacing: 24.h,
                    children: [
                      Text(
                        message ?? "",
                        textAlign: TextAlign.center,
                        style: Theme.of(ctx).textTheme.bodyLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSecondary,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),

                                  side: BorderSide(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (negativeOnClick != null) {
                                  negativeOnClick();
                                } else {
                                  Navigator.of(ctx).pop();
                                }
                              },
                              child: Text(
                                negativeText ?? AppLocalizations.of(ctx).no,
                                style: Theme.of(ctx).textTheme.headlineSmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSecondary,
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                            ),
                          ),
                          const Expanded(child: SizedBox()),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                ),
                              ),
                              onPressed: () {
                                if (positiveOnClick != null) {
                                  positiveOnClick();
                                } else {
                                  Navigator.of(ctx).pop();
                                }
                              },
                              child: Text(
                                positiveText ?? AppLocalizations.of(ctx).yes,
                                style: Theme.of(ctx).textTheme.headlineSmall
                                    ?.copyWith(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.onSecondary,
                                      fontWeight: FontWeight.w800,
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
          ),
        );
      },
    );
  }
}

