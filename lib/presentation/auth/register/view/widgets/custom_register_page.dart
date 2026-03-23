import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:elevate_super_fitness/presentation/auth/register/view_model/register_view_model.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/custom_widget/custom_glass_shape_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/register_events.dart';

class CustomRegisterPage extends StatelessWidget {
  final String title;
  final String desc;
  final Widget child;
  final bool removePadding;
  final RegisterViewModel registerViewModel;

  const CustomRegisterPage({
    super.key,
    required this.title,
    required this.desc,
    required this.child,
    this.removePadding = false,
    required this.registerViewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: AlignmentGeometry.center,
          child: SizedBox(
            width: 40.sp,
            height: 40.sp,
            child: ValueListenableBuilder(
              valueListenable: registerViewModel.registerProgress,
              builder: (context, value, child) {
                return Stack(
                  children: [
                    Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 3.w,
                        value: value,
                      ),
                    ),
                    Center(
                      child: Text(
                        "${registerViewModel.selectedPage.value}/6",
                        style: context.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          title.toUpperCase(),
          style: context.bodyLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.white,
          ),
        ).paddingSymmetric(horizontal: 16.w),
        ?Text(
          desc,
          style: context.bodyMedium?.copyWith(
            fontSize: 18.sp,
            color: AppColors.white[60],
          ),
        ).paddingSymmetric(horizontal: 16.w).showIf(desc != ""),
        SizedBox(height: 8.h),
        CustomGlassShapeWidget(
          removePadding: removePadding,
          child: Column(
            spacing: 24.h,
            children: [
              child,
              Padding(
                padding: removePadding
                    ? EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h)
                    : EdgeInsets.zero,
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      registerViewModel.doIntent(RegisterNextPageEvent());
                    },
                    child: Text(AppLocalizations.of(context).next),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

