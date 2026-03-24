import 'package:elevate_super_fitness/api/models/exercise_widget_model.dart';
import 'package:elevate_super_fitness/core/api_result/base_state.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_shimmer_item.dart';
import 'package:elevate_super_fitness/core/router/route_names.dart';
import 'package:elevate_super_fitness/domain/entites/muscles_response_entity.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view/widgets/custom_recommendation_item.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class ListOfRecommendationToDay extends StatelessWidget {
  const ListOfRecommendationToDay({super.key, this.randomMuscles});
  final BaseState<MusclesResponseEntity>? randomMuscles;

  @override
  Widget build(BuildContext context) {
    final heightMediaQuery = MediaQuery.of(context).size.height;

    return SliverToBoxAdapter(
      child: Builder(
        builder: (context) {
          if (randomMuscles?.isLoading == true) {
            return buildShimmerList(heightMediaQuery * 0.15, 104.w);
          }
          if (randomMuscles?.errorMessage != null) {
            return Center(child: Text(randomMuscles!.errorMessage!));
          }
          final muscles = randomMuscles?.data?.muscles ?? [];
          return LayoutBuilder(
            builder: (context, constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(maxHeight: heightMediaQuery * 0.15),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final selectedItem = muscles[index];
                    return GestureDetector(
                      key: Key("recommendation_item_$index"),
                      onTap: () => Navigator.pushNamed(
                        context,
                        RouteNames.exercise,
                        arguments: ExerciseWidgetModel(
                          primeMoverMuscleId: selectedItem.id ?? "",
                          exciseName: selectedItem.name ?? "",
                        ),
                      ),
                      child: CustomRecommendationItem(
                        title: selectedItem.name,
                        imagePath: selectedItem.image,
                      ),
                    );
                  },
                  separatorBuilder: (_, _) => SizedBox(width: 16.w),
                  itemCount: muscles.length,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
