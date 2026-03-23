import 'package:elevate_super_fitness/api/models/exercise_widget_model.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_shimmer_item.dart';
import 'package:elevate_super_fitness/core/router/route_names.dart';
import 'package:elevate_super_fitness/domain/entites/muscle_entity.dart';
import 'package:elevate_super_fitness/presentation/workout_page/view/widgets/custom_exercise_card.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class ListWorkoutsItem extends StatelessWidget {
  const ListWorkoutsItem({
    super.key,
    required this.musclesGroups,
    required this.isLoading,
  });

  final List<MuscleEntity> musclesGroups;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Expanded(child: buildShimmerGridWorkoutsItems());
    }

    if (musclesGroups.isEmpty) {
      return const Expanded(
        child: Center(child: Text("No workouts available")),
      );
    }

    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: GridView.builder(
          itemCount: musclesGroups.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final muscle = musclesGroups[index];
            return CustomExerciseCard(
              imageUrl: muscle.image ?? "",
              title: muscle.name ?? "",
              onTap: () {
                Navigator.pushNamed(
                  context,
                  RouteNames.exercise,
                  arguments: ExerciseWidgetModel(
                    primeMoverMuscleId: muscle.id ?? "",
                    exciseName: muscle.name ?? "",
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

