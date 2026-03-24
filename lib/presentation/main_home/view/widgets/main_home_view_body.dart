import 'package:elevate_super_fitness/core/constants/app_colors.dart';
import 'package:elevate_super_fitness/core/constants/app_icons.dart';
import 'package:elevate_super_fitness/core/constants/app_images.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view/screen/explore_page.dart';
import 'package:elevate_super_fitness/presentation/main_home/view/widgets/nav_item_custom_widget.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_events.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_states.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_view_model.dart';
import 'package:elevate_super_fitness/presentation/profile_page/view/screen/profile_page.dart';
import 'package:elevate_super_fitness/presentation/smart_coach_page/view/screen/smart_coach_page.dart';
import 'package:elevate_super_fitness/presentation/workout_page/view/screen/workouts_page.dart';
import 'package:flutter/material.dart';

class MainHomeViewBody extends StatelessWidget {
  final MainHomeViewModel mainHomeViewModel;
  final MainHomeStates state;
  const MainHomeViewBody({
    super.key,
    required this.mainHomeViewModel,
    required this.state,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: ResizeImage(
                AssetImage(AppImages.homeBgImage),
                width: 828,
                policy: ResizeImagePolicy.fit,
              ),
              fit: BoxFit.fill,
            ),
          ),
        ),
        PageView(
          controller: mainHomeViewModel.pageController,
          onPageChanged: (index) {
            mainHomeViewModel.doIntent(OnPageChangedEvent(index));
          },
          children: [
            ExplorePage(mainHomeViewModel: mainHomeViewModel),
            SmartCoachPage(mainHomeViewModel: mainHomeViewModel),
            WorkoutsPage(
              mainHomeViewModel: mainHomeViewModel,
              selectedTebId: mainHomeViewModel.selectedTabIdWorkouts,
            ),
            ProfilePage(mainHomeViewModel: mainHomeViewModel),
          ],
        ),
        Positioned(
          bottom: 32,
          left: 32,
          right: 32,
          child: Container(
            height: 69,
            decoration: BoxDecoration(
              color: AppColors.backGroundD.withOpacity(0.92),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavItemCustomWidget(
                  image: AppIcons.home,
                  label: AppLocalizations.of(context).explore,
                  isActive: state.selectedIndex == 0,
                  onTap: () {
                    mainHomeViewModel.doIntent(
                      OnBottomNavBarTappedEvent(index: 0),
                    );
                  },
                ),
                NavItemCustomWidget(
                  image: AppIcons.chatAi,
                  label: AppLocalizations.of(context).smartCoach,
                  isActive: state.selectedIndex == 1,
                  onTap: () {
                    mainHomeViewModel.doIntent(
                      OnBottomNavBarTappedEvent(index: 1),
                    );
                  },
                ),
                NavItemCustomWidget(
                  image: AppIcons.gym,
                  label: AppLocalizations.of(context).workouts,
                  isActive: state.selectedIndex == 2,
                  onTap: () {
                    mainHomeViewModel.doIntent(
                      OnBottomNavBarTappedEvent(index: 2),
                    );
                  },
                ),
                NavItemCustomWidget(
                  image: AppIcons.profile,
                  label: AppLocalizations.of(context).profile,
                  isActive: state.selectedIndex == 3,
                  onTap: () {
                    mainHomeViewModel.doIntent(
                      OnBottomNavBarTappedEvent(index: 3),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

