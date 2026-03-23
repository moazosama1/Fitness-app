import 'package:elevate_super_fitness/core/constants/constant_fake_data.dart';
import 'package:elevate_super_fitness/domain/entites/meal_category_entity.dart';
import 'package:elevate_super_fitness/domain/use_cases/get_meals_categories_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entites/meal_entity.dart';
import '../../../domain/use_cases/get_meals_by_category_use_case.dart';
import 'food_events.dart';

part 'food_state.dart';

@injectable
class FoodViewModel extends Cubit<FoodState> {
  static const Duration _fakeDelay = Duration(milliseconds: 350);

  FoodViewModel(
    GetMealsCategoriesUseCase getMealsCategoriesUseCase,
    GetMealsByCategoryUseCase getMealsByCategoryUseCase,
  ) : super(const FoodState());

  ValueNotifier<int> selectedTabIndex = ValueNotifier(0);

  void doIntent(FoodEvents events) {
    switch (events) {
      case GetMealsCategoriesFoodEvent():
        _getMealsCategories();
        break;
      case ChangeTabAndGetMealsFoodEvent():
        _getMealsByCategory(events.index);
        break;
    }
  }

  Future<void> _getMealsCategories() async {
    emit(const FoodState(isLoading: true));
    await Future.delayed(_fakeDelay);
    emit(
      state.copyWith(
        mealsCategoriesList: AppFakeData.foodCategories,
        isLoading: false,
      ),
    );
    if (AppFakeData.foodCategories.isNotEmpty) {
      _getMealsByCategory(0);
    }
  }

  Future<void> _getMealsByCategory(int index) async {
    _changeTab(index);
    emit(state.copyWith(isMealsLoading: true));
    await Future.delayed(_fakeDelay);
    final categories = state.mealsCategoriesList ?? const <MealCategoryEntity>[];
    if (categories.isEmpty || index < 0 || index >= categories.length) {
      emit(state.copyWith(mealsList: const [], isMealsLoading: false));
      return;
    }
    final category = categories[index].strCategory ?? '';
    final meals = AppFakeData.foodMealsByCategory[category] ?? const [];
    emit(state.copyWith(mealsList: meals, isMealsLoading: false));
  }

  void _changeTab(int index) {
    selectedTabIndex.value = index;
  }
}
