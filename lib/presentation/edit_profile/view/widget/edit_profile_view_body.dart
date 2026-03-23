import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:elevate_super_fitness/core/constants/app_icons.dart';
import 'package:elevate_super_fitness/presentation/edit_profile/view/widget/edit_profile_form.dart';
import 'package:elevate_super_fitness/presentation/edit_profile/view/widget/edit_profile_user_body_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../view_model/edit_profile_events.dart';
import '../../view_model/edit_profile_view_model.dart';
import 'edit_profile_avatar.dart';

class EditProfileViewBody extends StatelessWidget {
  EditProfileViewBody({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final editProfileViewModel = context.read<EditProfileViewModel>();
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SingleChildScrollView(
        child: Column(
          spacing: 40.h,
          children: [
            const SizedBox(),
            Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(true),
                    child: SvgPicture.asset(AppIcons.arrowBackIcon),
                  ),
                ),
                Text(
                  AppLocalizations.of(context).profile,
                  style: context.bodyLarge?.copyWith(
                    color: AppColors.white,
                    fontSize: 24.sp,
                  ),
                ),
              ],
            ),
            BlocBuilder<EditProfileViewModel, EditProfileState>(
              bloc: editProfileViewModel,
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Column(
                  spacing: 40.h,
                  children: [
                    const EditProfileAvatar(),
                    Form(key: formKey, child: const EditProfileForm()),
                    const EditProfileUserBodyInfo(),
                    SizedBox(
                      width: double.infinity,
                      child: ValueListenableBuilder(
                        valueListenable: editProfileViewModel.isButtonEnabled,
                        builder: (context, value, child) {
                          return ElevatedButton(
                            onPressed: value
                                ? () {
                                    if (formKey.currentState!.validate()) {
                                      editProfileViewModel.doIntent(
                                        UpdateUserProfileEvent(
                                          isBodyInfo: false,
                                        ),
                                      );
                                    }
                                  }
                                : null,
                            child: Text(
                              AppLocalizations.of(context).update,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: value == true
                                    ? theme.colorScheme.onSecondary
                                    : theme.colorScheme.onSecondary,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(),
          ],
        ),
      ),
    );
  }
}

