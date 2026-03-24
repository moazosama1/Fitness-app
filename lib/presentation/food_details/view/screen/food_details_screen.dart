import 'dart:ui' as ui;

import 'package:elevate_super_fitness/presentation/food_details/view_model/food_details_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../../../../core/di/di.dart';
import '../../view_model/food_details_view_model.dart';
import '../widget/food_details_view_body.dart';

class FoodDetailsScreen extends StatelessWidget {
  final String mealId;

  const FoodDetailsScreen({super.key, required this.mealId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            getIt<FoodDetailsViewModel>()
              ..doIntent(GetMealDetailsFoodDetailsEvent(mealId)),
        child: Stack(
          children: [
            ImageFiltered(
              imageFilter: ui.ImageFilter.blur(
                sigmaX: 5,
                sigmaY: 5,
                tileMode: TileMode.clamp,
              ),
              child: Image.asset(
                AppImages.foodBg,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                cacheWidth: 828,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppColors.backGroundL[110]!.withValues(alpha: 0.5),
                    offset: const Offset(0, 4),
                    blurRadius: 12.5,
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
            const FoodDetailsViewBody(),
          ],
        ),
      ),
    );
  }
}
