import 'package:elevate_super_fitness/core/constants/constant_fake_data.dart';
import 'package:elevate_super_fitness/domain/entites/meal_details_entity.dart';
import 'package:elevate_super_fitness/domain/entites/meal_entity.dart';
import 'package:elevate_super_fitness/domain/use_cases/get_meal_details_by_id_use_case.dart';
import 'package:elevate_super_fitness/domain/use_cases/get_meals_by_category_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'food_details_events.dart';

part 'food_details_state.dart';

@injectable
class FoodDetailsViewModel extends Cubit<FoodDetailsState> {
  static const Duration _fakeDelay = Duration(milliseconds: 350);

  FoodDetailsViewModel(
    GetMealsByCategoryUseCase getMealsByCategoryUseCase,
    GetMealDetailsByIdUseCase getMealDetailsByIdUseCase,
  ) : super(const FoodDetailsState());

  void doIntent(FoodDetailsEvents events) {
    switch (events) {
      case GetMealDetailsFoodDetailsEvent():
        _getMealDetailsById(events.mealId);
        break;
    }
  }

  Future<void> _getMealDetailsById(String id) async {
    emit(const FoodDetailsState(isLoading: true));
    await Future.delayed(_fakeDelay);
    final mealDetails = AppFakeData.foodMealDetailsById(id);
    emit(state.copyWith(mealDetails: mealDetails, isLoading: false));
    _getMealsByCategory(mealDetails.strCategory ?? '');
  }

  Future<void> _getMealsByCategory(String category) async {
    emit(state.copyWith(isMealsLoading: true));
    await Future.delayed(_fakeDelay);
    final meals = AppFakeData.foodRecommendedByCategory(category);
    meals.removeWhere((meal) => meal.idMeal == state.mealDetails?.idMeal);
    emit(state.copyWith(mealsList: meals, isMealsLoading: false));
  }
}
