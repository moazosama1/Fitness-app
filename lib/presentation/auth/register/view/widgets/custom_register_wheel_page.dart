import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';
import 'package:wheel_chooser/wheel_chooser.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../view_model/register_view_model.dart';
import 'custom_register_page.dart';

class CustomRegisterWheelPage extends StatelessWidget {
  final RegisterViewModel registerViewModel;
  final int initValue;
  final int minValue;
  final int maxValue;
  final String title;
  final String desc;
  final String wheelTitle;
  final dynamic Function(dynamic)? onChanged;

  const CustomRegisterWheelPage({
    super.key,
    required this.initValue,
    required this.minValue,
    required this.maxValue,
    required this.title,
    required this.desc,
    required this.wheelTitle,
    required this.registerViewModel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRegisterPage(
      registerViewModel: registerViewModel,
      removePadding: true,
      title: title,
      desc: desc,
      child: Column(
        spacing: 24.h,
        children: [
          SizedBox(height: 24.h),
          Text(
            wheelTitle,
            style: context.bodySmall?.copyWith(color: AppColors.mainColorL),
          ),
          SizedBox(
            height: 50.h,
            child: WheelChooser.integer(
              onValueChanged: onChanged,
              initValue: initValue,
              minValue: minValue,
              maxValue: maxValue,
              horizontal: true,
              selectTextStyle: context.bodyLarge?.copyWith(
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.mainColorL,
              ),
              unSelectTextStyle: context.bodyLarge?.copyWith(
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.white,
              ),
              itemSize: 65.w,
              perspective: 0.003,
            ),
          ),
          Icon(Icons.arrow_drop_up, color: AppColors.mainColorL, size: 24.sp),
        ],
      ),
    );
  }
}

