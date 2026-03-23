import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_register_bg.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

import '../../../../../core/constants/app_colors.dart';

class CustomRadioList<T extends Enum> extends StatelessWidget {
  final List<T> values;
  final T selectedValue;
  final String Function(T) labelBuilder;
  final String title;
  final String desc;
  final void Function(T?)? onChanged;
  final String buttonTitle;
  final VoidCallback onButtonClick;

  const CustomRadioList({
    super.key,
    required this.values,
    required this.selectedValue,
    required this.labelBuilder,
    required this.title,
    required this.desc,
    required this.onChanged,
    required this.buttonTitle,
    required this.onButtonClick,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRegisterBg(
      title: title,
      desc: desc,
      buttonTitle: buttonTitle,
      onButtonClick: onButtonClick,
      child: Column(
        children: values.map((item) {
          return Container(
            margin: EdgeInsets.only(top: 16.h),
            padding: EdgeInsets.only(left: 16.w, right: 8.w),
            decoration: BoxDecoration(
              color: AppColors.backGroundL[50]?.withValues(alpha: .3),
              border: Border.all(color: AppColors.white, width: 1.w),
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: RadioListTile<T>(
              fillColor: MaterialStateProperty.resolveWith((states) {
                if (states.contains(MaterialState.selected)) {
                  return AppColors.mainColorL;
                }
                return AppColors.backGroundL[90];
              }),
              contentPadding: EdgeInsets.zero,
              dense: true,
              controlAffinity: ListTileControlAffinity.trailing,
              title: Text(
                labelBuilder(item),
                style: context.bodySmall?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
              value: item,
              groupValue: selectedValue,
              onChanged: onChanged,
            ),
          );
        }).toList(),
      ),
    );
  }
}

