import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_cached_network_image.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_shimmer_item.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_states.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class SectionProfileInfo extends StatelessWidget {
  const SectionProfileInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final local = AppLocalizations.of(context);
    return BlocBuilder<MainHomeViewModel, MainHomeStates>(
      builder: (context, state) {
        if (state.userInfo?.isLoading == true) {
          return buildShimmerMainProfileItem();
        }
        if (state.userInfo?.errorMessage != null) {
          return Text(
            state.userInfo?.errorMessage ?? local.error,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSecondary,
            ),
          );
        }
        return Column(
          children: [
            ClipOval(
              child: CustomCachedNetworkImage(
                key: const Key(WidgetsKeys.kProfileScreenImageUserKey),
                imageUrl: state.userInfo?.data?.photo ?? "",
                fit: BoxFit.cover,
                width: 100.w,
                height: 100.h,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              state.userInfo?.data?.firstName ?? "",
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSecondary,
              ),
              key: const Key(WidgetsKeys.kProfileScreenUserNameTextKey),
            ),
          ],
        );
      },
    );
  }
}

