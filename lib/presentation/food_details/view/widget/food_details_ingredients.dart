import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:elevate_super_fitness/domain/entites/meal_details_entity.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

import '../../../../core/constants/app_colors.dart';

class FoodDetailsIngredients extends StatelessWidget {
  final MealDetailsEntity mealDetails;

  const FoodDetailsIngredients({super.key, required this.mealDetails});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        color: AppColors.backGroundL.withValues(alpha: .8),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(children: [
        ...filterIngredientsData(context, mealDetails),
      ]),
    );
  }

  Widget buildIngredientItem(BuildContext context, String title, String value) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: context.bodyMedium?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: context.bodySmall?.copyWith(color: AppColors.mainColorL),
            ),
          ],
        ),
        SizedBox(height: 4.h),
        Divider(color: AppColors.dividerColor, thickness: 1.h),
      ],
    );
  }

  List<Widget> filterIngredientsData(
    BuildContext context,
    MealDetailsEntity mealDetails,
  ) {
    final data = mealDetails.toMap();
    final List<Widget> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = data['strIngredient$i'];
      final measure = data['strMeasure$i'];

      if (ingredient != null &&
          ingredient.toString().trim().isNotEmpty &&
          measure != null &&
          measure.toString().trim().isNotEmpty) {
        ingredients.add(buildIngredientItem(context, ingredient, measure));
      }
    }
    return ingredients;
  }
}

