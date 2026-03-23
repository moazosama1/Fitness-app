import 'package:elevate_super_fitness/core/constants/app_colors.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_auth_bg.dart';
import 'package:elevate_super_fitness/presentation/auth/register/view/widgets/custom_register_wheel_page.dart';
import 'package:elevate_super_fitness/presentation/auth/register/view/widgets/register_form_widget.dart';
import 'package:elevate_super_fitness/presentation/auth/register/view/widgets/register_gender_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

import '../../../../../core/custom_widget/custom_dialog.dart';
import '../../../../../core/di/di.dart';
import '../../../../../core/enums/goal_enum.dart';
import '../../../../../core/enums/level_enum.dart';
import '../../../../../core/router/route_names.dart';
import '../../../../../generated/l10n.dart';
import '../../view_model/register_events.dart';
import '../../view_model/register_view_model.dart';
import '../widgets/custom_register_radio_list.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late final RegisterViewModel registerViewModel;

  bool isDialogVisible = false;

  @override
  void initState() {
    super.initState();
    registerViewModel = getIt<RegisterViewModel>();
  }

  @override
  void dispose() {
    registerViewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<RegisterViewModel, RegisterState>(
        bloc: registerViewModel,
        listener: (context, state) {
          if (isDialogVisible) {
            Navigator.of(context).pop();
            isDialogVisible = false;
          }

          if (state.registerState?.isLoading == true) {
            CustomDialog.fitnessLoading(context: context);
            isDialogVisible = true;
          }

          if (state.registerState?.errorMessage != null) {
            CustomDialog.fitnessPositiveButton(
              context: context,
              title: AppLocalizations.of(context).error,
              message: state.registerState?.errorMessage,
            );
          }

          if (state.registerState?.data != null) {
            CustomDialog.fitnessPositiveButton(
              context: context,
              cancelable: false,
              title: AppLocalizations.of(context).success,
              message: AppLocalizations.of(context).accountCreatedSuccessfully,
              positiveOnClick: () {
                Navigator.of(context).pushReplacementNamed(RouteNames.login);
              },
            );
          }
        },
        child: Stack(
          children: [
            CustomAuthBg(
              child: Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    registerViewModel.doIntent(ChangeRegisterPageEvent(index));
                  },
                  controller: registerViewModel.pageController,
                  children: [
                    RegisterFormWidget(registerViewModel: registerViewModel),
                    RegisterGenderPage(registerViewModel: registerViewModel),
                    ValueListenableBuilder(
                      valueListenable: registerViewModel.selectedAge,
                      builder: (context, value, child) {
                        return CustomRegisterWheelPage(
                          registerViewModel: registerViewModel,
                          initValue: value,
                          minValue: 8,
                          maxValue: 80,
                          title: AppLocalizations.of(context).howOldAreYou,
                          desc: AppLocalizations.of(
                            context,
                          ).thisHelpsUsCreateYourPersonalizedPlan,
                          wheelTitle: AppLocalizations.of(context).year,
                          onChanged: (age) {
                            if (age != null) {
                              registerViewModel.doIntent(
                                ChangeRegisterAgeEvent(age),
                              );
                            }
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: registerViewModel.selectedWeight,
                      builder: (context, value, child) {
                        return CustomRegisterWheelPage(
                          registerViewModel: registerViewModel,
                          initValue: value,
                          minValue: 30,
                          maxValue: 200,
                          title: AppLocalizations.of(context).whatIsYourWeight,
                          desc: AppLocalizations.of(
                            context,
                          ).thisHelpsUsCreateYourPersonalizedPlan,
                          wheelTitle: AppLocalizations.of(context).kg,
                          onChanged: (weight) {
                            if (weight != null) {
                              registerViewModel.doIntent(
                                ChangeRegisterWeightEvent(weight),
                              );
                            }
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: registerViewModel.selectedHeight,
                      builder: (context, value, child) {
                        return CustomRegisterWheelPage(
                          registerViewModel: registerViewModel,
                          initValue: value,
                          minValue: 100,
                          maxValue: 200,
                          title: AppLocalizations.of(context).whatIsYourHeight,
                          desc: AppLocalizations.of(
                            context,
                          ).thisHelpsUsCreateYourPersonalizedPlan,
                          wheelTitle: AppLocalizations.of(context).cm,
                          onChanged: (height) {
                            if (height != null) {
                              registerViewModel.doIntent(
                                ChangeRegisterHeightEvent(height),
                              );
                            }
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: registerViewModel.selectedGoal,
                      builder: (context, value, child) {
                        return CustomRegisterRadioList<GoalEnum>(
                          registerViewModel: registerViewModel,
                          values: GoalEnum.values,
                          selectedValue: value,
                          labelBuilder: (goal) => goal.displayName,
                          title: AppLocalizations.of(context).whatIsYourGoal,
                          desc: AppLocalizations.of(
                            context,
                          ).thisHelpsUsCreateYourPersonalizedPlan,
                          onChanged: (goal) {
                            if (goal != null) {
                              registerViewModel.doIntent(
                                ChangeRegisterGoalEvent(goal),
                              );
                            }
                          },
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: registerViewModel.selectedLevel,
                      builder: (context, value, child) {
                        return CustomRegisterRadioList<LevelEnum>(
                          registerViewModel: registerViewModel,
                          values: LevelEnum.values,
                          selectedValue: value,
                          labelBuilder: (level) => level.displayName,
                          title: AppLocalizations.of(
                            context,
                          ).yourRegularPhysicalActivityLevel,
                          desc: "",
                          onChanged: (level) {
                            if (level != null) {
                              registerViewModel.doIntent(
                                ChangeRegisterLevelEvent(level),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: registerViewModel.selectedPage,
              builder: (context, value, child) {
                return Visibility(
                  visible: value >= 2,
                  child: Positioned(
                    left: 16.w,
                    top: 52.h,
                    child: GestureDetector(
                      onTap: () {
                        registerViewModel.doIntent(RegisterPreviousPageEvent());
                      },
                      child: Container(
                        width: 24.sp,
                        height: 24.sp,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.mainColorL,
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(right: 2.w),
                          child: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

