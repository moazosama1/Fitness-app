import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../view_model/edit_profile_view_model.dart';
import '../screen/edit_profile_user_body_info_screen.dart';

class EditProfileUserBodyInfo extends StatelessWidget {
  const EditProfileUserBodyInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final editProfileViewModel = context.read<EditProfileViewModel>();
    final editProfileState = editProfileViewModel.state;
    return Column(
      spacing: 16.h,
      children: [
        _buildInfo(
          context: context,
          title: AppLocalizations.of(context).yourWeight,
          value: editProfileState.userData?.weight?.toString() ?? "",
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: editProfileViewModel,
                  child: EditProfileUserBodyInfoScreen(
                    page: EditProfileUserBodyInfoPagesEnum.weight,
                  ),
                ),
              ),
            );
          },
        ),
        _buildInfo(
          context: context,
          title: AppLocalizations.of(context).yourGoal,
          value: editProfileState.userData?.goal ?? "",
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: editProfileViewModel,
                  child: EditProfileUserBodyInfoScreen(
                    page: EditProfileUserBodyInfoPagesEnum.goal,
                  ),
                ),
              ),
            );
          },
        ),
        _buildInfo(
          context: context,
          title: AppLocalizations.of(context).yourActivityLevel,
          value: editProfileState.userData?.activityLevel ?? "",
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: editProfileViewModel,
                  child: EditProfileUserBodyInfoScreen(
                    page: EditProfileUserBodyInfoPagesEnum.level,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildInfo({
    required BuildContext context,
    required String title,
    required String value,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.h,
        children: [
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "$title (",
                  style: _buildTextStyle(context: context),
                ),
                TextSpan(
                  text: AppLocalizations.of(context).tapToEdit,
                  style: _buildTextStyle(
                    context: context,
                    color: AppColors.mainColorL,
                  ),
                ),
                TextSpan(
                  text: ")",
                  style: _buildTextStyle(context: context),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: AppColors.backGroundL[50]?.withValues(alpha: .3),
              border: Border.all(color: AppColors.white, width: 1.w),
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Text(
              value,
              style: context.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextStyle? _buildTextStyle({required BuildContext context, Color? color}) {
    return context.bodyLarge?.copyWith(
      fontSize: 14.sp,
      color: color ?? AppColors.white,
    );
  }
}

