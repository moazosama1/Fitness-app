import 'package:elevate_super_fitness/presentation/food/view/widget/food_meal_item.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

import '../../../../core/router/route_names.dart';
import '../../../../domain/entites/meal_entity.dart';

class FoodTabBarView extends StatelessWidget {
  final List<MealEntity> mealsList;

  const FoodTabBarView({super.key, required this.mealsList});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(right: 16.w, left: 16.w, bottom: 16.h),
      itemCount: mealsList.length,
      gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
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
          onTap: (){
            Navigator.of(
              context,
            ).pushNamed(RouteNames.foodDetails, arguments: meal.idMeal ?? "");
          },
        );
      },
    );
  }
}

