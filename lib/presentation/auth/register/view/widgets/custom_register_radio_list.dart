import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../view_model/register_view_model.dart';
import 'custom_register_page.dart';

class CustomRegisterRadioList<T extends Enum> extends StatelessWidget {
  final RegisterViewModel registerViewModel;
  final List<T> values;
  final T selectedValue;
  final String Function(T) labelBuilder;
  final String title;
  final String desc;
  final void Function(T?)? onChanged;

  const CustomRegisterRadioList({
    super.key,
    required this.registerViewModel,
    required this.values,
    required this.selectedValue,
    required this.labelBuilder,
    required this.title,
    required this.desc,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomRegisterPage(
      registerViewModel: registerViewModel,
      title: title,
      desc: desc,
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

