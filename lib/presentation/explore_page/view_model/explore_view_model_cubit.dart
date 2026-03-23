import 'package:elevate_super_fitness/core/api_result/base_state.dart';
import 'package:elevate_super_fitness/core/constants/app_images.dart';
import 'package:elevate_super_fitness/core/constants/constant_fake_data.dart';
import 'package:elevate_super_fitness/domain/entites/meals_categories_response_entity.dart';
import 'package:elevate_super_fitness/domain/entites/muscle_group_details_entity.dart';
import 'package:elevate_super_fitness/domain/entites/muscles_group_response_entity.dart';
import 'package:elevate_super_fitness/domain/entites/muscles_response_entity.dart';
import 'package:elevate_super_fitness/domain/use_cases/get_all_meals_categories_use_case.dart';
import 'package:elevate_super_fitness/domain/use_cases/get_all_muscles_by_muscle_group_id_use_case.dart';
import 'package:elevate_super_fitness/domain/use_cases/get_all_muscles_groups_use_case.dart';
import 'package:elevate_super_fitness/domain/use_cases/get_random_muscles_use_case.dart';
import 'package:elevate_super_fitness/domain/use_cases/get_user_logged_data_use_case.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view_model/explore_event.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'explore_view_model_state.dart';

@injectable
class ExploreViewModelCubit extends Cubit<ExploreViewModelState> {
  ExploreViewModelCubit(
    GetUserLoggedDataUseCase userLoggedDataUseCase,
    GetRandomMusclesUseCase getRandomMusclesUseCase,
    GetAllMusclesGroupsUseCase allMusclesGroupsUseCase,
    GetAllMusclesByMuscleGroupIdUseCase getAllMusclesByMuscleGroupIdUseCase,
    GetAllMealsCategoriesUseCase getAllMealsCategoriesUseCase,
  ) : super(const ExploreViewModelState());
  static const Duration _fakeDelay = Duration(milliseconds: 450);

  String selectedId = "";
  ValueNotifier<int> selectedCategory = ValueNotifier<int>(0);
  final categories = [
    {'title': AppLocalizations().gym, 'image': AppImages.gymImage},
    {'title': AppLocalizations().fitness, 'image': AppImages.fitnessImage},
    {'title': AppLocalizations().yoga, 'image': AppImages.yogaImage},
    {'title': AppLocalizations().aerobics, 'image': AppImages.aerobicsImage},
    {'title': AppLocalizations().trainer, 'image': AppImages.trainerImage},
  ];
  void doIntent(ExploreEvent event) {
    switch (event) {
      case ExploreGetAllDataEvent():
        _getAllData();
      case ExploreGetMusclesByMuscleGroupIdEvent():
        selectedId = event.id;
        _getAllMusclesByMuscleGroupId(selectedId);
    }
  }

  Future<void> _getAllData() async {
    await Future.wait([
      _getRandomMuscles(),
      _getAllMealsCategories(),
      _getAllMusclesGroups(),
    ]);
    await _getAllMusclesByMuscleGroupId(selectedId);
  }

  Future<void> _getRandomMuscles() async {
    emit(state.copyWith(randomMuscles: BaseState.loading()));
    await Future.delayed(_fakeDelay);
    emit(
      state.copyWith(
        randomMuscles: BaseState.success(
          MusclesResponseEntity(
            message: 'loaded from fake data',
            totalMuscles: AppFakeData.exploreRecommendationToDay.length,
            muscles: AppFakeData.exploreRecommendationToDay,
          ),
        ),
      ),
    );
  }

  Future<void> _getAllMusclesGroups() async {
    emit(state.copyWith(musclesGroup: BaseState.loading()));
    await Future.delayed(_fakeDelay);
    selectedId = AppFakeData.exploreUpcomingGroups.first.id ?? '';
    emit(
      state.copyWith(
        musclesGroup: BaseState.success(
          const MusclesGroupResponseEntity(
            message: 'loaded from fake data',
            musclesGroup: AppFakeData.exploreUpcomingGroups,
          ),
        ),
      ),
    );
  }

  Future<void> _getAllMusclesByMuscleGroupId(String selectedI) async {
    emit(state.copyWith(musclesGroupDetailsById: BaseState.loading()));
    await Future.delayed(_fakeDelay);
    final items =
      AppFakeData.exploreUpcomingByGroup[selectedI] ??
      AppFakeData.exploreUpcomingByGroup.values.first;
    final groupName =
      AppFakeData.exploreUpcomingGroups
            .where((g) => g.id == selectedI)
            .map((g) => g.name)
            .firstWhere((name) => name != null, orElse: () => 'Workout') ??
        'Workout';
    emit(
      state.copyWith(
        musclesGroupDetailsById: BaseState.success(
          MuscleGroupDetailsEntity(
            message: 'loaded from fake data',
            muscleGroupId: selectedI,
            muscleGroupName: groupName,
            musclesEntity: items,
          ),
        ),
      ),
    );
  }

  Future<void> _getAllMealsCategories() async {
    emit(state.copyWith(mealsCategory: BaseState.loading()));
    await Future.delayed(_fakeDelay);
    emit(
      state.copyWith(
        mealsCategory: BaseState.success(
          const MealsCategoriesResponseEntity(
            categories: AppFakeData.exploreRecommendationForYou,
          ),
        ),
      ),
    );
  }
}
