import 'package:elevate_super_fitness/core/api_result/base_state.dart';
import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:elevate_super_fitness/domain/entites/muscle_group_details_entity.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view/widgets/custom_recommendation_item.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class ListOfUpcomingItem extends StatelessWidget {
  const ListOfUpcomingItem({super.key, this.musclesGroupDetailsById});
  final BaseState<MuscleGroupDetailsEntity>? musclesGroupDetailsById;
  @override
  Widget build(BuildContext context) {
    final heightMediaQuery = MediaQuery.of(context).size.height;
    return SliverToBoxAdapter(
      child: Builder(
        builder: (context) {
          if (musclesGroupDetailsById?.isLoading == true) {
            return SizedBox(height: heightMediaQuery * 0.125);
          }
          if (musclesGroupDetailsById?.errorMessage != null) {
            return Center(child: Text(musclesGroupDetailsById!.errorMessage!));
          }
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: heightMediaQuery * 0.125),
            child: ListView.separated(
              key: const Key(WidgetsKeys.kExploreScreenListTabBarItemsKey),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final selectedItem =
                    musclesGroupDetailsById?.data?.musclesEntity?[index];
                return CustomRecommendationItem(
                  key: Key("recommendation_item_$index"),
                  border: false,
                  title: selectedItem?.name,
                  imagePath: selectedItem?.image,
                );
              },
              separatorBuilder: (_, _) => SizedBox(width: 16.w),
              itemCount:
                  musclesGroupDetailsById?.data?.musclesEntity?.length ?? 0,
            ),
          );
        },
      ),
    );
  }
}
