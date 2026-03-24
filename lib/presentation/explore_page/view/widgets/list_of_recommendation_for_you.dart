import 'package:elevate_super_fitness/core/api_result/base_state.dart';
import 'package:elevate_super_fitness/core/router/route_names.dart';
import 'package:elevate_super_fitness/domain/entites/meals_categories_response_entity.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view/widgets/custom_recommendation_item.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class ListOfRecommendationForYou extends StatelessWidget {
  const ListOfRecommendationForYou({super.key, this.mealsCategory});
  final BaseState<MealsCategoriesResponseEntity>? mealsCategory;
  @override
  Widget build(BuildContext context) {
    final heightMediaQuery = MediaQuery.of(context).size.height;
    return SliverToBoxAdapter(
      child: Builder(
        builder: (context) {
          if (mealsCategory?.isLoading == true) {
            return SizedBox(height: heightMediaQuery * 0.15);
          }
          if (mealsCategory?.errorMessage != null) {
            return Center(child: Text(mealsCategory!.errorMessage!));
          }
          return LayoutBuilder(
            builder: (context, constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(maxHeight: heightMediaQuery * 0.15),
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  addAutomaticKeepAlives: false,
                  itemBuilder: (context, index) {
                    final selectedItem =
                        mealsCategory?.data?.categories?[index];
                    return GestureDetector(
                      key: Key("recommendation_item_$index"),
                      onTap: () {
                        Navigator.of(
                          context,
                        ).pushNamed(RouteNames.food, arguments: index);
                      },
                      child: CustomRecommendationItem(
                        title: selectedItem?.strCategory,
                        imagePath: selectedItem?.strCategoryThumb,
                      ),
                    );
                  },
                  separatorBuilder: (_, _) => SizedBox(width: 16.w),
                  itemCount: mealsCategory?.data?.categories?.length ?? 0,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
