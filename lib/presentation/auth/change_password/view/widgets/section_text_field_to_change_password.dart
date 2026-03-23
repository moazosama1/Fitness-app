import 'package:elevate_super_fitness/core/constants/app_colors.dart';
import 'package:elevate_super_fitness/core/constants/app_icons.dart';
import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:elevate_super_fitness/core/enums/change_password.dart';
import 'package:elevate_super_fitness/core/utils/validations.dart';
import 'package:elevate_super_fitness/domain/entites/requests/change_password_request_entity.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:elevate_super_fitness/presentation/auth/change_password/view_model/change_password_event.dart';
import 'package:elevate_super_fitness/presentation/auth/change_password/view_model/change_password_view_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';
import 'package:flutter_svg/svg.dart';

class SectionTextFieldToChangePassword extends StatelessWidget {
  const SectionTextFieldToChangePassword({
    super.key,
    required this.oldPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.globalKey,
  });
  final TextEditingController oldPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final GlobalKey<FormState> globalKey;
  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final cubit = context.read<ChangePasswordViewModel>();
    return Form(
      key: globalKey,
      child: Column(
        spacing: 17.h,
        children: [
          ValueListenableBuilder<bool>(
            valueListenable: cubit.showOldPassword,
            builder: (context, value, child) => TextFormField(
              validator: Validations.validatePassword,
              controller: oldPasswordController,
              key: const Key(
                WidgetsKeys.kChangePasswordScreenOldPasswordFieldKey,
              ),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
              obscureText: value,
              decoration: InputDecoration(
                hintText: local.oldPassword,
                prefixIcon: Padding(
                  padding: EdgeInsets.all(14.sp),
                  child: SvgPicture.asset(
                    key: const Key(
                      WidgetsKeys.kChangePasswordScreenPreIconOldPasswordFieldKey,
                    ),
                    AppIcons.lockSvg,
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
                suffixIcon: GestureDetector(
                  onTap: () => cubit.doIntent(
                    ChangePasswordShowIconEvent(
                      enumEvent: ChangePasswordEnum.oldPassword,
                    ),
                  ),
                  child: Icon(
                    value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.backGroundL[90],
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: cubit.showNewPassword,
            builder: (context, value, child) => TextFormField(
              validator: Validations.validatePassword,
              controller: newPasswordController,
              key: const Key(
                WidgetsKeys.kChangePasswordScreenNewPasswordFieldKey,
              ),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
              obscureText: value,
              decoration: InputDecoration(
                hintText: local.newPassword,
                prefixIcon: Padding(
                  padding: EdgeInsets.all(14.sp),
                  child: SvgPicture.asset(
                    key: const Key(
                      WidgetsKeys.kChangePasswordScreenPreIconNewPasswordFieldKey,
                    ),
                    AppIcons.lockSvg,
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
                suffixIcon: GestureDetector(
                  onTap: () => cubit.doIntent(
                    ChangePasswordShowIconEvent(
                      enumEvent: ChangePasswordEnum.newPassword,
                    ),
                  ),
                  child: Icon(
                    value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.backGroundL[90],
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: cubit.showConfirmPassword,
            builder: (context, value, child) => TextFormField(
              validator: (value) => Validations.validateConfirmPassword(
                newPasswordController.text,
                confirmPasswordController.text,
              ),
              controller: confirmPasswordController,
              key: const Key(
                WidgetsKeys.kChangePasswordScreenConfirmPasswordFieldKey,
              ),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
              obscureText: value,
              decoration: InputDecoration(
                hintText: local.confirmPassword,
                prefixIcon: Padding(
                  padding: EdgeInsets.all(14.sp),
                  child: SvgPicture.asset(
                    key: const Key(
                      WidgetsKeys.kChangePasswordScreenPreIconConfirmPasswordFieldKey,
                    ),
                    AppIcons.lockSvg,
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
                suffixIcon: GestureDetector(
                  onTap: () => cubit.doIntent(
                    ChangePasswordShowIconEvent(
                      enumEvent: ChangePasswordEnum.confirmPassword,
                    ),
                  ),
                  child: Icon(
                    value
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined,
                    color: AppColors.backGroundL[90],
                    size: 20.sp,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 38.w,
            width: double.infinity,
            child: ElevatedButton(
              key: const Key(WidgetsKeys.kChangePasswordScreenButtonDoneKey),
              onPressed: () {
                if (globalKey.currentState!.validate()) {
                  cubit.doIntent(
                    ChangePasswordExecuteEvent(
                      request: ChangePasswordRequestEntity(
                        password: oldPasswordController.text,
                        newPassword: newPasswordController.text,
                      ),
                    ),
                  );
                }
              },
              child: Text(
                key: const Key(
                  WidgetsKeys.kChangePasswordScreenTextButtonDoneKey,
                ),
                local.done,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.onSecondary,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

