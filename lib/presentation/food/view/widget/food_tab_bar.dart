import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../domain/entites/meal_category_entity.dart';
import '../../view_model/food_view_model.dart';

class FoodTabBar extends StatelessWidget {
  final TabController tabController;
  final List<MealCategoryEntity> mealsCategoriesList;

  const FoodTabBar({
    super.key,
    required this.mealsCategoriesList,
    required this.tabController,
  });

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: true,
      tabAlignment: TabAlignment.start,
      dividerHeight: 0,
      dividerColor: Colors.transparent,
      indicatorColor: Colors.transparent,
      indicatorPadding: EdgeInsets.zero,
      tabs: [
        ...mealsCategoriesList.asMap().entries.map((entry) {
          final index = entry.key;
          final category = entry.value;
          return buildTab(
            context: context,
            category: category.strCategory ?? "",
            index: index,
          );
        }),
      ],
    );
  }

  Widget buildTab({
    required BuildContext context,
    required String category,
    required int index,
  }) {
    return ValueListenableBuilder(
      valueListenable: context.read<FoodViewModel>().selectedTabIndex,
      builder: (context, value, child) {
        return Container(
          decoration: BoxDecoration(
            color: index == value ? AppColors.mainColorL : null,
            borderRadius: BorderRadius.circular(100.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Text(category, style: context.bodySmall?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.w700,
            ),),
          ),
        );
      }
    );
  }
}

