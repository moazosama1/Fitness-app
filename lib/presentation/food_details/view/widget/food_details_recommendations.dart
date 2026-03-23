import 'package:elevate_super_fitness/presentation/food/view/widget/food_meal_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

import '../../../../domain/entites/meal_entity.dart';
import '../../view_model/food_details_events.dart';
import '../../view_model/food_details_view_model.dart';

class FoodDetailsRecommendations extends StatelessWidget {
  final List<MealEntity> mealsList;

  const FoodDetailsRecommendations({super.key, required this.mealsList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 16.h),
      itemCount: mealsList.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 18.sp,
        crossAxisSpacing: 18.sp,
        childAspectRatio: 1 / 1,
      ),
      itemBuilder: (context, index) {
        final meal = mealsList[index];
        return FoodMealItem(
          mealImage: meal.strMealThumb ?? "",
          mealName: meal.strMeal ?? "",
          onTap: () {
            context.read<FoodDetailsViewModel>().doIntent(
              GetMealDetailsFoodDetailsEvent(meal.idMeal ?? ""),
            );
          },
        );
      },
    );
  }
}

