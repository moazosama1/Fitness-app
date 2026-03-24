import 'package:elevate_super_fitness/api/models/exercise_widget_model.dart';
import 'package:elevate_super_fitness/core/constants/app_colors.dart';
import 'package:elevate_super_fitness/core/constants/app_images.dart';
import 'package:elevate_super_fitness/core/di/di.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:elevate_super_fitness/presentation/exercise/view/widgets/exercise_card.dart';
import 'package:elevate_super_fitness/presentation/exercise/view/widgets/exercise_levels_tab_bar_item.dart';
import 'package:elevate_super_fitness/presentation/exercise/view/widgets/exercise_video_cover_section.dart';
import 'package:elevate_super_fitness/presentation/exercise/view_model/exercise_events.dart';
import 'package:elevate_super_fitness/presentation/exercise/view_model/exercise_states.dart';
import 'package:elevate_super_fitness/presentation/exercise/view_model/exercise_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExerciseViewBody extends StatefulWidget {
  final ExerciseWidgetModel exerciseWidgetModel;
  const ExerciseViewBody({super.key, required this.exerciseWidgetModel});

  @override
  State<ExerciseViewBody> createState() => _ExerciseViewBodyState();
}

class _ExerciseViewBodyState extends State<ExerciseViewBody> {
  @override
  void initState() {
    super.initState();
    exerciseViewModel.doIntent(
      OnLoadDifficultyLevelsEvent(
        primeMoverMuscleId: widget.exerciseWidgetModel.primeMoverMuscleId,
      ),
    );
  }

  void loadFirstLevelExercises(List difficultyLevels) {
    if (exerciseFirstLoad && difficultyLevels.isNotEmpty) {
      exerciseFirstLoad = false;
      exerciseViewModel.doIntent(
        OnLoadExercisesEvent(
          primeMoverMuscleId: widget.exerciseWidgetModel.primeMoverMuscleId,
          difficultyLevelId: difficultyLevels[0].id,
        ),
      );
    }
  }

  int selectedIndex = 0;
  bool exerciseFirstLoad = true;
  final ExerciseViewModel exerciseViewModel = getIt.get<ExerciseViewModel>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ExerciseViewModel, ExerciseStates>(
      bloc: exerciseViewModel,
      builder: (context, state) {
        final difficultyLevels = state.difficultyLevelsSuccess;
        final exercises = state.exercisesListSuccess;
        if (!state.difficultyLevelsLoading &&
            state.difficultyLevelsErrorMessage == null) {
          loadFirstLevelExercises(difficultyLevels);
        }
        return DefaultTabController(
          initialIndex: selectedIndex,
          length: difficultyLevels.length,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: ResizeImage(
                      AssetImage(AppImages.homeBgImage),
                      width: 828,
                      policy: ResizeImagePolicy.fit,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(0.5),
              ),
              ListView(
                children: [
                  ExerciseVideoCoverSection(
                    title: widget.exerciseWidgetModel.exciseName,
                  ),
                  state.difficultyLevelsLoading
                      ? const SizedBox(
                          height: 200,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : state.difficultyLevelsErrorMessage != null
                      ? Center(
                          child: Text(
                            state.difficultyLevelsErrorMessage ?? "",
                            style: Theme.of(context).textTheme.bodyMedium!
                                .copyWith(color: AppColors.pureWhite),
                          ),
                        )
                      : difficultyLevels.isEmpty
                      ? SizedBox(
                          height: 200,
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context).noExerciseAvailable,
                              style: Theme.of(context).textTheme.bodyMedium!
                                  .copyWith(color: AppColors.pureWhite),
                            ),
                          ),
                        )
                      : Column(
                          children: [
                            Container(
                              width: double.infinity,
                              height: 50,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 9,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                color: AppColors.backGroundL.withOpacity(0.9),
                              ),
                              child: TabBar(
                                onTap: (index) {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                  exerciseViewModel.doIntent(
                                    OnLoadExercisesEvent(
                                      primeMoverMuscleId: widget
                                          .exerciseWidgetModel
                                          .primeMoverMuscleId,
                                      difficultyLevelId:
                                          difficultyLevels[index].id!,
                                    ),
                                  );
                                },
                                isScrollable: true,
                                tabAlignment: TabAlignment.start,
                                indicatorColor: Colors.transparent,
                                dividerColor: Colors.transparent,
                                labelPadding: const EdgeInsets.only(right: 60),
                                tabs: difficultyLevels.map((level) {
                                  return ExerciseLevelsTabBarItem(
                                    isSelected:
                                        selectedIndex ==
                                        difficultyLevels.indexOf(level),
                                    exerciseLevelName: level.name ?? "level",
                                  );
                                }).toList(),
                              ),
                            ),
                            const SizedBox(height: 8),
                            state.exercisesListLoading
                                ? const SizedBox(
                                    height: 200,
                                    child: Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  )
                                : state.exercisesListErrorMessage != null
                                ? SizedBox(
                                    height: 200,
                                    child: Center(
                                      child: Text(
                                        state.exercisesListErrorMessage!,
                                      ),
                                    ),
                                  )
                                : exercises.isEmpty
                                ? Center(
                                    child: Text(
                                      AppLocalizations.of(
                                        context,
                                      ).noExerciseAvailable,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(color: AppColors.pureWhite),
                                    ),
                                  )
                                : SizedBox(
                                    height: (exercises.length * 101) + 24,
                                    child: TabBarView(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      children: difficultyLevels.map((level) {
                                        return ListView.builder(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 16,
                                          ),
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: exercises.length,
                                          itemBuilder: (context, index) {
                                            return ExerciseCard(
                                              exerciseEntity: exercises[index],
                                              isFirstIndex: index == 0,
                                              isLastIndex:
                                                  index == exercises.length - 1,
                                            );
                                          },
                                        );
                                      }).toList(),
                                    ),
                                  ),
                          ],
                        ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
