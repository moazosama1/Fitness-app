import 'package:elevate_super_fitness/core/constants/app_colors.dart';
import 'package:elevate_super_fitness/core/constants/app_icons.dart';
import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:elevate_super_fitness/core/utils/validations.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:elevate_super_fitness/presentation/auth/login/view_model/login_view_model.dart';
import 'package:elevate_super_fitness/presentation/auth/login/view_model/login_view_model_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';
import 'package:flutter_svg/svg.dart';

class SectionLoginFormFiled extends StatelessWidget {
  const SectionLoginFormFiled({super.key, required this.globalKey});
  final GlobalKey<FormState> globalKey;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);
    final cubit = context.read<LoginViewModel>();
    return Form(
      key: globalKey,
      child: Column(
        children: [
          SizedBox(
            height: 36.h,
            child: TextFormField(
              validator: Validations.validateEmail,
              controller: cubit.emailController,

              key: const Key(WidgetsKeys.kLoginScreenEmailFormFiledKey),
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
              decoration: InputDecoration(
                errorStyle: const TextStyle(height: 0.08),
                hintText: local.email,
                prefixIcon: Padding(
                  padding: EdgeInsets.all(8.sp),
                  child: SvgPicture.asset(
                    key: const Key(
                      WidgetsKeys.kLoginScreenPrefixIconEmailFormFiledKey,
                    ),
                    AppIcons.mailIconSvg,
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.h),
          ValueListenableBuilder<bool>(
            valueListenable: cubit.passwordVisible,
            builder: (context, value, child) => SizedBox(
              height: 36.h,
              child: TextFormField(
                validator: Validations.validateAuthPassword,
                controller: cubit.passwordController,
                key: const Key(WidgetsKeys.kLoginScreenPasswordFormFiledKey),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSecondary,
                ),
                obscureText: value,
                decoration: InputDecoration(
                  errorStyle: const TextStyle(height: 0.08),
                  hintText: local.password,
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(8.sp),
                    child: SvgPicture.asset(
                      key: const Key(
                        WidgetsKeys.kLoginScreenPrefixIconPasswordFormFiledKey,
                      ),
                      AppIcons.lockSvg,
                      height: 20.h,
                      width: 20.w,
                    ),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () =>
                        cubit.doIntent(LoginViewModelVisiblePasswordEvent()),
                    child: Icon(
                      value
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: AppColors.backGroundL[90],
                      size: 18.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

