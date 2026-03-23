import 'package:elevate_super_fitness/core/api_result/base_state.dart';
import 'package:elevate_super_fitness/core/constants/constant_fake_data.dart';
import 'package:elevate_super_fitness/domain/entites/muscle_group_details_entity.dart';
import 'package:elevate_super_fitness/domain/entites/muscles_group_response_entity.dart';
import 'package:elevate_super_fitness/domain/use_cases/get_all_muscles_by_muscle_group_id_use_case.dart';
import 'package:elevate_super_fitness/domain/use_cases/get_all_muscles_groups_use_case.dart';
import 'package:elevate_super_fitness/presentation/workout_page/view_model/workout_event.dart';
import 'package:elevate_super_fitness/presentation/workout_page/view_model/workout_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class WorkoutViewModel extends Cubit<WorkoutStates> {
  static const Duration _fakeDelay = Duration(milliseconds: 450);

  WorkoutViewModel(
    GetAllMusclesByMuscleGroupIdUseCase getAllMusclesByMuscleGroupIdUseCase,
    GetAllMusclesGroupsUseCase allMusclesGroupsUseCase,
  ) : super(const WorkoutStates());

  void doIntent(WorkoutEvents event) {
    if (event is WorkoutEvent) {
      _getAllMusclesGroups();
    } else if (event is MusclesEvent) {
      _getAllMusclesByMuscleGroupId(event.id);
    }
  }

  Future<void> _getAllMusclesGroups() async {
    emit(state.copyWith(musclesGroup: BaseState.loading()));
    await Future.delayed(_fakeDelay);
    emit(
      state.copyWith(
        musclesGroup: BaseState.success(
          const MusclesGroupResponseEntity(
            message: 'loaded from fake data',
            musclesGroup: AppFakeData.workoutGroups,
          ),
        ),
      ),
    );
  }

  Future<void> _getAllMusclesByMuscleGroupId(String selectedId) async {
    emit(state.copyWith(musclesGroupDetailsById: BaseState.loading()));
    await Future.delayed(_fakeDelay);
    final items =
      AppFakeData.workoutsByGroup[selectedId] ??
      AppFakeData.workoutsByGroup.values.first;
    final groupName =
      AppFakeData.workoutGroups
            .where((g) => g.id == selectedId)
            .map((g) => g.name)
            .firstWhere((name) => name != null, orElse: () => 'Workout') ??
        'Workout';
    emit(
      state.copyWith(
        musclesGroupDetailsById: BaseState.success(
          MuscleGroupDetailsEntity(
            message: 'loaded from fake data',
            muscleGroupId: selectedId,
            muscleGroupName: groupName,
            musclesEntity: items,
          ),
        ),
      ),
    );
  }
}
