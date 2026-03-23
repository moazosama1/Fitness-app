import 'package:elevate_super_fitness/core/constants/app_colors.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_shimmer_item.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class CustomTabBarPage extends StatelessWidget {
  final TabController tabController;
  final List<String> tabs;
  final bool isLoading;
  const CustomTabBarPage({
    super.key,
    required this.tabController,
    required this.tabs,
    required this.isLoading,
  });
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (isLoading == true) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: buildShimmerList(36.h, 104.w),
          );
        }
        return SizedBox(
          height: 44.h,
          child: TabBar(
            tabAlignment: TabAlignment.start,
            dividerColor: Colors.transparent,
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            controller: tabController,
            isScrollable: true,
            labelPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0,
            ),
            indicatorPadding: EdgeInsets.symmetric(
              vertical: 6.w,
              horizontal: 5.h,
            ),
            indicator: BoxDecoration(
              color: AppColors.mainColorL,
              borderRadius: BorderRadius.circular(20),
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
            onTap: (index) {
              tabController.index = index;
            },
            tabs: tabs.map((name) => Tab(text: name)).toList(),
          ),
        );
      },
    );
  }
}

