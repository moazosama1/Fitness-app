import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_dialog.dart';
import 'package:elevate_super_fitness/core/router/route_names.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:elevate_super_fitness/presentation/profile_page/view/widgets/section_profile_info.dart';
import 'package:elevate_super_fitness/presentation/profile_page/view/widgets/section_profile_items.dart';
import 'package:elevate_super_fitness/presentation/profile_page/view_model/main_profile_view_model_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class ProfilePageBody extends StatelessWidget {
  const ProfilePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);
    return BlocListener<MainProfileViewModelCubit, MainProfileViewModelState>(
      listener: (context, state) {
        if (state.logout?.isLoading == true) {
          CustomDialog.fitnessLoading(context: context);
        }
        if (state.logout?.isLoading == false) {
          Navigator.pop(context);
        }
        if (state.logout?.data != null) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.login,
            (route) => false,
          );
        }
        if (state.logout?.errorMessage != null) {
          CustomDialog.fitnessPositiveButton(
            context: context,
            message: state.logout?.errorMessage,
          );
        }
      },
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 40.h),
            Text(
              local.profile,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
              key: const Key(WidgetsKeys.kProfileScreenTitlePageKey),
            ),
            SizedBox(height: 40.h),
            const SectionProfileInfo(
              key: Key(WidgetsKeys.kProfileScreenSectionProfileInfoKey),
            ),
            SizedBox(height: 40.h),
            const SectionProfileItems(
              key: Key(WidgetsKeys.kProfileScreenSectionProfileItemsKey),
            ),
          ],
        ),
      ),
    );
  }
}

