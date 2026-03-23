import 'package:elevate_super_fitness/core/constants/app_colors.dart';
import 'package:elevate_super_fitness/core/constants/app_icons.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_dialog.dart';
import 'package:elevate_super_fitness/core/router/route_names.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_events.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_view_model.dart';
import 'package:elevate_super_fitness/presentation/profile_page/view/widgets/custom_profile_item_widget.dart';
import 'package:elevate_super_fitness/presentation/profile_page/view_model/main_profile_event.dart';
import 'package:elevate_super_fitness/presentation/profile_page/view_model/main_profile_view_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class SectionProfileItems extends StatelessWidget {
  const SectionProfileItems({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);
    final cubit = BlocProvider.of<MainProfileViewModelCubit>(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.h),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        decoration: BoxDecoration(
          color: const Color(0xFF242424).withOpacity(0.8),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Column(
          spacing: 16.h,
          children: [
            CustomProfileItemWidget(
              imagePath: AppIcons.profileIcon,
              title: local.editProfile,
              onTap: () async {
                final editData = await Navigator.pushNamed(
                  context,
                  RouteNames.editProfile,
                );
                if (!context.mounted) return;
                if (editData == true) {
                  context.read<MainHomeViewModel>().doIntent(
                    GetUserInfoMainHomeEvent(),
                  );
                }
              },
            ),
            CustomProfileItemWidget(
              imagePath: AppIcons.changePasswordIcon,
              title: local.changePassword,
              onTap: () =>
                  Navigator.pushNamed(context, RouteNames.changePassword),
            ),
            CustomProfileItemWidget(
              imagePath: AppIcons.languageIcon,
              title: local.selectLanguage,
              widgetSecondIcon: SizedBox(
                width: 20.w,
                height: 20.h,
                child: ValueListenableBuilder(
                  valueListenable: cubit.switcherLocal,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: 0.7,
                      alignment: Alignment.center,
                      child: Switch(
                        padding: const EdgeInsets.all(0),
                        value: value,
                        onChanged: (value) {
                          cubit.doIntent(
                            MainProfileChangeLocalEvent(value: value),
                          );
                        },
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: theme.colorScheme.onSecondary,
                        activeTrackColor: theme.colorScheme.primary,
                        inactiveTrackColor: AppColors.dividerColor,
                        hoverColor: theme.colorScheme.primary,
                      ),
                    );
                  },
                ),
              ),
            ),
            CustomProfileItemWidget(
              imagePath: AppIcons.lockSettingIcon,
              title: local.security,
              onTap: () =>
                  cubit.doIntent(MainProfileGetSecurityAndConfigEvent()),
            ),
            CustomProfileItemWidget(
              imagePath: AppIcons.privacyPolicyIcon,
              title: local.privacyPolicy,
            ),
            CustomProfileItemWidget(
              imagePath: AppIcons.helpIcon,
              title: local.help,
            ),
            CustomProfileItemWidget(
              imagePath: AppIcons.logoutIcon,
              title: local.logout,
              onTap: () {
                CustomDialog.fitnessPositiveAndNegativeButton(
                  context: context,
                  message: local.doYouSureLogout,
                  positiveOnClick: () {
                    context.read<MainProfileViewModelCubit>().doIntent(
                      MainProfileLogoutEvent(),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

