import 'package:elevate_super_fitness/core/custom_widget/custom_glass_shape_widget.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/utils/validations.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/forget_password_events.dart';
import '../../view_model/forget_password_view_model.dart';

class EmailInputContainer extends StatefulWidget {
  final ForgetPasswordViewModel forgetPasswordViewModel;
  final VoidCallback onNext;

  const EmailInputContainer({
    super.key,
    required this.onNext,
    required this.forgetPasswordViewModel,
  });

  @override
  State<EmailInputContainer> createState() => _EmailInputContainerState();
}

class _EmailInputContainerState extends State<EmailInputContainer> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              const SizedBox(height: 25),
              Text(
                local.enterYouEmail,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                local.forgetPassword,
                textAlign: TextAlign.center,
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
          child: Form(
            key: widget.forgetPasswordViewModel.forgetPasswordFormKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: Validations.validateEmail,
                  controller: widget.forgetPasswordViewModel.emailController,

                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(height: 0.08),
                    hintText: local.email,
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.white70,
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
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
                          .forgetPasswordFormKey
                          .currentState!
                          .validate()) {
                        widget.forgetPasswordViewModel.doIntent(
                          ForgetPasswordEvent(),
                        );
                      }
                    },
                    child: Text(
                      local.sentOtp,
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
        ),
      ],
    );
  }
}

