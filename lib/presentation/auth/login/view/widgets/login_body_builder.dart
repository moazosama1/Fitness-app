import 'package:elevate_super_fitness/core/constants/app_icons.dart';
import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_auth_bg.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_glass_shape_widget.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_or_divider.dart';
import 'package:elevate_super_fitness/core/router/route_names.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:elevate_super_fitness/presentation/auth/login/view/widgets/section_login_form_filed.dart';
import 'package:elevate_super_fitness/presentation/auth/login/view/widgets/section_text_login.dart';
import 'package:elevate_super_fitness/presentation/auth/login/view_model/login_view_model.dart';
import 'package:elevate_super_fitness/presentation/auth/login/view_model/login_view_model_event.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';
import 'package:flutter_svg/svg.dart';

class LoginBodyBuilder extends StatelessWidget {
  const LoginBodyBuilder({super.key, required this.globalKey});
  final GlobalKey<FormState> globalKey;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);
    return CustomAuthBg(
      child: Expanded(
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            children: [
              SizedBox(height: 77.h, width: double.infinity),
              const SectionTextLogin(),
              CustomGlassShapeWidget(
                child: Column(
                  children: [
                    Text(
                      key: const Key(WidgetsKeys.kLoginScreenLoginTitleTextKey),
                      local.login,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.onSecondary,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Column(
                      children: [
                        SectionLoginFormFiled(globalKey: globalKey),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              key: const Key(
                                WidgetsKeys
                                    .kLoginScreenTextButtonForgetPasswordKey,
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.forgetPassword,
                                );
                              },
                              child: Text(
                                local.forgotPassword,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        const CustomOrDivider(),
                        SizedBox(height: 24.h),
                        Row(
                          key: const Key(
                            WidgetsKeys.kLoginScreenAnotherButtonToLoginKey,
                          ),
                          mainAxisAlignment: MainAxisAlignment.center,
                          spacing: 16.w,
                          children: [
                            SvgPicture.asset(AppIcons.faceBook),
                            SvgPicture.asset(AppIcons.googleSvg),
                            SvgPicture.asset(AppIcons.appelSvg),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        SizedBox(
                          height: 38.h,
                          width: double.infinity,
                          child: ElevatedButton(
                            key: const Key(WidgetsKeys.kLoginScreenLoginButton),
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(
                                  20.r,
                                ),
                              ),
                            ),
                            onPressed: () {
                              if (globalKey.currentState!.validate()) {
                                context.read<LoginViewModel>().doIntent(
                                  LoginViewModelSignInEvent(),
                                );
                              }
                            },
                            child: Text(
                              local.login,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                color: theme.colorScheme.onSecondary,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        TextButton(
                          key: const Key(
                            WidgetsKeys.kLoginScreenDummyEmailButton,
                          ),
                          onPressed: () {
                            context.read<LoginViewModel>().doIntent(
                              LoginViewModelSignInWithDummyEmailEvent(),
                            );
                          },
                          child: Text(
                            'Use Dummy Email',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text.rich(
                            key: const Key(WidgetsKeys.kLoginScreenTextRichKey),
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: local.doNotHaveAccountYet,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.onSecondary,
                                  ),
                                ),
                                TextSpan(
                                  text: local.register,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.w800,
                                    decoration: TextDecoration.underline,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pushNamed(
                                        context,
                                        RouteNames.register,
                                      );
                                    },
                                ),
                              ],
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(height: 12.h),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
