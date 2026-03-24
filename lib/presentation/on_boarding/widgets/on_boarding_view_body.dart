import 'dart:ui';

import 'package:elevate_super_fitness/core/constants/app_colors.dart';
import 'package:elevate_super_fitness/core/constants/app_images.dart';
import 'package:elevate_super_fitness/core/router/route_names.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:elevate_super_fitness/presentation/on_boarding/model/on_boarding_page_view_content_model.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingViewBody extends StatefulWidget {
  const OnBoardingViewBody({super.key});

  @override
  State<OnBoardingViewBody> createState() => _OnBoardingViewBodyState();
}

class _OnBoardingViewBodyState extends State<OnBoardingViewBody> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  final List<OnBoardingPageViewContentModel> onBoardingDataList = [
    OnBoardingPageViewContentModel(
      image: AppImages.onboarding1,
      title: AppLocalizations().onBoarding1Title,
      desc: AppLocalizations().onBoardingDesc,
    ),
    OnBoardingPageViewContentModel(
      image: AppImages.onboarding2,
      title: AppLocalizations().onBoarding2Title,
      desc: AppLocalizations().onBoardingDesc,
    ),
    OnBoardingPageViewContentModel(
      image: AppImages.onboarding3,
      title: AppLocalizations().onBoarding3Title,
      desc: AppLocalizations().onBoardingDesc,
    ),
  ];

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
                AssetImage(AppImages.onBoardingBgImage),
                width: 828,
                policy: ResizeImagePolicy.fit,
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        PageView.builder(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          itemCount: onBoardingDataList.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 66),
                  child: Container(
                    width: double.infinity,
                    height: 500.h,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ResizeImage(
                          AssetImage(onBoardingDataList[index].image),
                          width: 828,
                          policy: ResizeImagePolicy.fit,
                        ),
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  ),
                ),
                ?currentIndex != onBoardingDataList.length - 1
                    ? Positioned(
                        top: 25,
                        right: 5,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              RouteNames.login,
                            );
                          },
                          child: Text(
                            AppLocalizations.of(context).skip,
                            style: Theme.of(context).textTheme.bodySmall!
                                .copyWith(
                                  fontSize: 14,
                                  color: AppColors.lightGray,
                                ),
                          ),
                        ),
                      )
                    : null,
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    borderRadius: const BorderRadiusGeometry.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50),
                    ),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 34.6, sigmaY: 34.6),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(
                          vertical: 25.h,
                          horizontal: 16.w,
                        ),
                        color: AppColors.backGroundL[10]?.withAlpha(
                          (0.1 * 255).round(),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Center(
                              child: Text(
                                onBoardingDataList[index].title,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge!
                                    .copyWith(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.white,
                                    ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Center(
                              child: Text(
                                onBoardingDataList[index].desc,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium!
                                    .copyWith(
                                      fontSize: 16,
                                      color: AppColors.backGroundL[90],
                                    ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: SmoothPageIndicator(
                                controller: _pageController,
                                count: onBoardingDataList.length,
                                effect: ExpandingDotsEffect(
                                  activeDotColor: AppColors.mainColorL,
                                  dotColor: AppColors.lightGray,
                                  dotHeight: 8,
                                  dotWidth: 8,
                                  spacing: 8,
                                ),
                                onDotClicked: (index) {
                                  _pageController.animateToPage(
                                    index,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                  );
                                },
                              ),
                            ),
                            const SizedBox(height: 20),
                            ?currentIndex == 0
                                ? SizedBox(
                                    height: 40,
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _pageController.nextPage(
                                          duration: const Duration(
                                            milliseconds: 300,
                                          ),
                                          curve: Curves.ease,
                                        );
                                      },
                                      child: Text(
                                        AppLocalizations.of(context).next,
                                      ),
                                    ),
                                  )
                                : currentIndex > 0
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        height: 40,
                                        width: 90,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            foregroundColor:
                                                AppColors.lightGray,
                                            side: BorderSide(
                                              width: 1,
                                              color: AppColors.mainColorL,
                                            ),
                                            elevation: 0,
                                          ),
                                          onPressed: () {
                                            _pageController.previousPage(
                                              duration: const Duration(
                                                milliseconds: 300,
                                              ),
                                              curve: Curves.ease,
                                            );
                                          },
                                          child: Text(
                                            AppLocalizations.of(context).back,
                                          ),
                                        ),
                                      ),
                                      currentIndex ==
                                              onBoardingDataList.length - 1
                                          ? SizedBox(
                                              height: 40,
                                              width: 90,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Navigator.pushReplacementNamed(
                                                    context,
                                                    RouteNames.login,
                                                  );
                                                },
                                                child: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  ).doIt,
                                                ),
                                              ),
                                            )
                                          : SizedBox(
                                              height: 40,
                                              width: 90,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  _pageController.nextPage(
                                                    duration: const Duration(
                                                      milliseconds: 300,
                                                    ),
                                                    curve: Curves.ease,
                                                  );
                                                },
                                                child: Text(
                                                  AppLocalizations.of(
                                                    context,
                                                  ).next,
                                                ),
                                              ),
                                            ),
                                    ],
                                  )
                                : null,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

