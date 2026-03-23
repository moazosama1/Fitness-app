import 'package:elevate_super_fitness/core/constants/constant_fake_data.dart';
import 'package:elevate_super_fitness/domain/use_cases/get_all_difficulty_levels_by_prime_mover_muscle_use_case.dart';
import 'package:elevate_super_fitness/domain/use_cases/get_exercises_by_prime_mover_muscle_and_difficulty_level_use_case.dart';
import 'package:elevate_super_fitness/presentation/exercise/view_model/exercise_events.dart';
import 'package:elevate_super_fitness/presentation/exercise/view_model/exercise_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ExerciseViewModel extends Cubit<ExerciseStates> {
  static const Duration _fakeDelay = Duration(milliseconds: 350);

  ExerciseViewModel(
    GetAllDifficultyLevelsByPrimeMoverMuscleUseCase
    getAllDifficultyLevelsByPrimeMoverMuscleUseCase,
    GetExercisesByPrimeMoverMuscleAndDifficultyLevelUseCase
    getExercisesByPrimeMoverMuscleAndDifficultyLevelUseCase,
  ) : super(const ExerciseStates());

  void doIntent(ExerciseEvents event) {
    switch (event) {
      case OnLoadDifficultyLevelsEvent():
        _getAllDifficultyLevelsByPrimeMoverMuscle(event.primeMoverMuscleId);
        break;
      case OnLoadExercisesEvent():
        _getExercisesByPrimeMoverMuscleandDifficultyLevel(
          event.primeMoverMuscleId,
          event.difficultyLevelId,
        );
    }
  }

  Future<void> _getAllDifficultyLevelsByPrimeMoverMuscle(
    String primeMoverMuscleId,
  ) async {
    emit(state.copyWith(difficultyLevelsLoading: true));
    await Future.delayed(_fakeDelay);
    emit(
      state.copyWith(
        difficultyLevelsLoading: false,
        difficultyLevelsSuccess: AppFakeData.exerciseDifficultyLevels,
      ),
    );
  }

  Future<void> _getExercisesByPrimeMoverMuscleandDifficultyLevel(
    String primeMoverMuscleId,
    String difficultyLevelId,
  ) async {
    emit(state.copyWith(exercisesListLoading: true));
    await Future.delayed(_fakeDelay);
    final exercises = AppFakeData.exercisesByLevel(difficultyLevelId);
    emit(
      state.copyWith(
        exercisesListLoading: false,
        exercisesListSuccess: exercises,
      ),
    );
  }
}
