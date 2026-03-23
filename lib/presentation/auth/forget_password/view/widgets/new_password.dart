import 'package:elevate_super_fitness/core/constants/app_colors.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_glass_shape_widget.dart';
import 'package:elevate_super_fitness/core/utils/validations.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

import '../../view_model/forget_password_events.dart';
import '../../view_model/forget_password_view_model.dart';

class CreateNewPasswordContainer extends StatefulWidget {
  final ForgetPasswordViewModel forgetPasswordViewModel;
  final VoidCallback onDone;

  const CreateNewPasswordContainer({
    super.key,
    required this.onDone,
    required this.forgetPasswordViewModel,
  });

  @override
  State<CreateNewPasswordContainer> createState() =>
      _CreateNewPasswordContainerState();
}

class _CreateNewPasswordContainerState
    extends State<CreateNewPasswordContainer> {
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);
    return Form(
      key: widget.forgetPasswordViewModel.resetPasswordFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 25),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  local.makeSureIts8CharactersOrMore,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  local.createNewPassword,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 25),
          CustomGlassShapeWidget(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: Validations.validateAuthPassword,
                  controller:
                      widget.forgetPasswordViewModel.newPasswordController,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(height: 0.08),
                    hintText: local.password,
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.white70,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white70,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller:
                      widget.forgetPasswordViewModel.confirmPasswordController,
                  obscureText: _obscureConfirm,
                  validator: (value) => Validations.validateConfirmPassword(
                    value,
                    widget.forgetPasswordViewModel.newPasswordController.text,
                  ),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(height: 0.08),
                    hintText: local.password,
                    prefixIcon: const Icon(
                      Icons.lock_outline,
                      color: Colors.white70,
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirm
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white70,
                      ),
                      onPressed: () =>
                          setState(() => _obscureConfirm = !_obscureConfirm),
                    ),
                  ),
                ),

                const SizedBox(height: 25),
                SizedBox(
                  width: width,
                  height: 38,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColorL,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),

                    onPressed: () {
                      if (widget
                          .forgetPasswordViewModel
                          .resetPasswordFormKey
                          .currentState!
                          .validate()) {
                        widget.forgetPasswordViewModel.doIntent(
                          ResetPasswordEvent(),
                        );
                      }
                    },
                    child: Text(
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
          ),
        ],
      ),
    );
  }
}

