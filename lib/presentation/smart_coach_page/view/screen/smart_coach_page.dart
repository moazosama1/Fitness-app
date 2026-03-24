
import 'package:elevate_super_fitness/core/constants/app_colors.dart';
import 'package:elevate_super_fitness/core/constants/app_icons.dart';
import 'package:elevate_super_fitness/core/constants/app_images.dart';
import 'package:elevate_super_fitness/core/di/di.dart';
import 'package:elevate_super_fitness/core/router/route_names.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_events.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_states.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_view_model.dart';
import 'package:elevate_super_fitness/presentation/smart_coach_page/view_model/smart_coach_events.dart';
import 'package:elevate_super_fitness/presentation/smart_coach_page/view_model/smart_coach_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SmartCoachPage extends StatefulWidget {
  final MainHomeViewModel mainHomeViewModel;
  const SmartCoachPage({super.key, required this.mainHomeViewModel});

  @override
  State<SmartCoachPage> createState() => _SmartCoachPageState();
}

class _SmartCoachPageState extends State<SmartCoachPage> {
  @override
  void initState() {
    smartCoachViewModel.doIntent(OnGetUserLoggedDataEvent());
    super.initState();
  }

  final SmartCoachViewModel smartCoachViewModel = getIt
      .get<SmartCoachViewModel>();
  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      key: const ValueKey('smart coach page'),
      onNotification: (notification) {
        if (notification is ScrollUpdateNotification) {
          widget.mainHomeViewModel.doIntent(
            OnScrollUpdateEvent(
              notification.metrics.pixels,
              notification.scrollDelta ?? 0,
            ),
          );
        }
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: ResizeImage(
                    AssetImage(AppImages.chatBg),
                    width: 828,
                    policy: ResizeImagePolicy.fit,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.55),
            ),

            SingleChildScrollView(
              child: SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 16,
                        left: 16,
                        bottom: 25,
                      ),
                      child: SizedBox(
                        height: 50.h,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppIcons.arrowBackIcon),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                BlocBuilder<MainHomeViewModel, MainHomeStates>(
                                  builder: (context, state) {
                                    final name =
                                        state.userInfo?.data?.firstName ?? "";
                                    AppImages.userImage;
                                    return Text(
                                      "${AppLocalizations.of(context).hi} $name,",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.pureWhite,
                                          ),
                                    );
                                  },
                                ),
                                Text(
                                  AppLocalizations.of(
                                    context,
                                  ).iAmYourSmartCoach,
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.pureWhite,
                                      ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 24,
                              width: 24,
                              child: ImageIcon(
                                const AssetImage(AppIcons.menuIcon),
                                color: AppColors.mainColorL,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: 300,
                        width: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: ResizeImage(
                              AssetImage(AppImages.robot),
                              width: 600,
                              policy: ResizeImagePolicy.fit,
                            ),
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      height: 194,
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 36,
                        horizontal: 30,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.backGroundL.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            AppLocalizations.of(
                              context,
                            ).howCanIAssistYouToday,
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyLarge!
                                .copyWith(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.pureWhite,
                                ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 38,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  RouteNames.chat,
                                );
                              },
                              child: Text(
                                AppLocalizations.of(context).getStarted,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 55),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

