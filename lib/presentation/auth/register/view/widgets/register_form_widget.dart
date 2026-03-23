import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:elevate_super_fitness/core/router/route_names.dart';
import 'package:elevate_super_fitness/core/utils/validations.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/custom_widget/custom_glass_shape_widget.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/register_events.dart';
import '../../view_model/register_view_model.dart';

class RegisterFormWidget extends StatelessWidget {
  final RegisterViewModel registerViewModel;

  const RegisterFormWidget({super.key, required this.registerViewModel});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 34.h),
        Text(
          AppLocalizations.of(context).heyThere,
          style: context.bodyMedium?.copyWith(
            fontSize: 18.sp,
            color: AppColors.white[60],
          ),
        ).paddingSymmetric(horizontal: 16.w),
        Text(
          AppLocalizations.of(context).createAnAccount.toUpperCase(),
          style: context.bodyLarge?.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.white,
          ),
        ).paddingSymmetric(horizontal: 16.w),
        SizedBox(height: 8.h),
        CustomGlassShapeWidget(
          child: Form(
            key: registerViewModel.formKey,
            child: Column(
              spacing: 16.h,
              children: [
                Text(
                  AppLocalizations.of(context).register,
                  style: context.bodyLarge?.copyWith(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
                buildTextFormField(
                  context: context,
                  controller: registerViewModel.firstNameController,
                  validator: Validations.validateFullName,
                  icon: Icons.person_outline_outlined,
                  hint: AppLocalizations.of(context).firstName,
                ),
                buildTextFormField(
                  context: context,
                  controller: registerViewModel.lastNameController,
                  validator: Validations.validateFullName,
                  icon: Icons.person_outline_outlined,
                  hint: AppLocalizations.of(context).lastName,
                ),
                buildTextFormField(
                  context: context,
                  controller: registerViewModel.emailController,
                  validator: Validations.validateEmail,
                  icon: Icons.email_outlined,
                  hint: AppLocalizations.of(context).email,
                  keyboardType: TextInputType.emailAddress,
                ),
                ValueListenableBuilder(
                  valueListenable: registerViewModel.isPasswordVisible,
                  builder: (context, value, child) {
                    return TextFormField(
                      controller: registerViewModel.passwordController,
                      validator: Validations.validateAuthPassword,
                      obscureText: !value,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.lock_outline,
                          color: AppColors.backGroundL[90],
                        ),
                        hintText: AppLocalizations.of(context).password,
                        suffixIcon: IconButton(
                          onPressed: () {
                            registerViewModel.doIntent(
                              ToggleRegisterPasswordVisibilityEvent(),
                            );
                          },
                          icon: Icon(
                            value
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: AppColors.backGroundL[90],
                          ),
                        ),
                      ),
                      style: context.bodySmall?.copyWith(
                        color: AppColors.white,
                      ),
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                    );
                  },
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (registerViewModel.formKey.currentState!.validate()) {
                        registerViewModel.doIntent(RegisterNextPageEvent());
                      }
                    },
                    child: Text(AppLocalizations.of(context).register),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 4.w,
                  children: [
                    Text(
                      AppLocalizations.of(context).alreadyHaveAccount,
                      style: context.headlineSmall?.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(
                          context,
                        ).pushReplacementNamed(RouteNames.login);
                      },
                      child: Text(
                        AppLocalizations.of(context).login,
                        style: context.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: AppColors.orange,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buildTextFormField({
    required BuildContext context,
    required TextEditingController controller,
    required String? Function(String?) validator,
    required IconData icon,
    required String hint,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppColors.backGroundL[90]),
        hintText: hint,
        hintStyle: context.bodySmall?.copyWith(
          color: AppColors.backGroundL[90],
        ),
      ),
      style: context.bodySmall?.copyWith(color: AppColors.white),
      keyboardType: keyboardType ?? TextInputType.name,
      textInputAction: textInputAction ?? TextInputAction.next,
    );
  }
}

