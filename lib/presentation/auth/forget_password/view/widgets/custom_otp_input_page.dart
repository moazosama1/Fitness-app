import 'package:elevate_super_fitness/core/custom_widget/custom_glass_shape_widget.dart';
import 'package:elevate_super_fitness/core/utils/validations.dart';
import 'package:elevate_super_fitness/presentation/auth/forget_password/view_model/forget_password_view_model.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/forget_password_events.dart';

class CustomOtpInputPage extends StatefulWidget {
  const CustomOtpInputPage({super.key, required this.viewModel});
  final ForgetPasswordViewModel viewModel;
  @override
  State<CustomOtpInputPage> createState() => _CustomOtpInputPageState();
}

class _CustomOtpInputPageState extends State<CustomOtpInputPage> {
  final GlobalKey<FormState> otbCOdeFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);

    return Form(
      key: otbCOdeFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Text(
                  local.otpCode,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  local.enterYourOTPCheckYourEmail,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 25),
              ],
            ),
          ),

          CustomGlassShapeWidget(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                PinCodeTextField(
                  hintStyle: TextStyle(color: AppColors.mainColorL),
                  controller: widget.viewModel.resetCodeController,
                  backgroundColor: Colors.transparent,
                  appContext: context,
                  length: 6,
                  animationType: AnimationType.fade,
                  cursorColor: AppColors.mainColorL,
                  keyboardType: TextInputType.number,
                  validator: (value) => Validations.validateSixNumber(value),
                  enableActiveFill: false,
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.mainColorL,
                  ),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeColor: AppColors.mainColorL,
                    inactiveColor: AppColors.mainColorL,
                    selectedColor: AppColors.mainColorL,
                    activeFillColor: AppColors.mainColorL,
                    selectedFillColor: AppColors.mainColorL,
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 38.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mainColorL,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    onPressed: () {
                      if (otbCOdeFormKey.currentState!.validate()) {
                        widget.viewModel.doIntent(
                          VerifyResetCodeEvent(
                            otpCode: widget.viewModel.resetCodeController.text,
                          ),
                        );
                      }
                    },
                    child: Text(
                      AppLocalizations.of(context).confirm,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.onSecondary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                InkWell(
                  onTap: () {
                    widget.viewModel.doIntent(ResendOtpEvent());
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppLocalizations.of(context).didnotReceiveCode,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        AppLocalizations.of(context).resend,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: AppColors.mainColorL,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                    ],
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

