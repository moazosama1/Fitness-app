import 'package:elevate_super_fitness/core/api_result/base_state.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_shimmer_item.dart';
import 'package:elevate_super_fitness/domain/entites/muscles_group_response_entity.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view/widgets/custom_explore_tab_bar_item.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view_model/explore_view_model_cubit.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_events.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class ListUpcomingWorkoutsCategory extends StatelessWidget {
  const ListUpcomingWorkoutsCategory({super.key, this.musclesGroup});
  final BaseState<MusclesGroupResponseEntity>? musclesGroup;

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ExploreViewModelCubit>(
      context,
      listen: false,
    );
    final heightMediaQuery = MediaQuery.of(context).size.height;
    return SliverToBoxAdapter(
      child: Builder(
        builder: (context) {
          if (musclesGroup?.isLoading == true) {
            return buildShimmerCategoryItemList(heightMediaQuery);
          }
          if (musclesGroup?.errorMessage != null) {
            return Center(
              child: Text(
                musclesGroup!.errorMessage!,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }
          final musclesGroupList = musclesGroup?.data?.musclesGroup ?? [];
          return ConstrainedBox(
            constraints: BoxConstraints(maxHeight: heightMediaQuery * 0.045),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final selectedItem = musclesGroupList[index];
                return GestureDetector(
                  onTap: () {
                    if (!cubit.isClosed) {
                      cubit.selectedCategory.value = index;
                      context.read<MainHomeViewModel>().doIntent(
                        OnBottomNavBarTappedEvent(
                          index: 2,
                          selectedTabId: selectedItem.id,
                        ),
                      );
                    }
                  },
                  child: ValueListenableBuilder<int>(
                    valueListenable: context
                        .read<ExploreViewModelCubit>()
                        .selectedCategory,
                    builder: (context, value, child) => CustomExploreTabBarItem(
                      isActive: value == index,
                      title: selectedItem.name,
                    ),
                  ),
                );
              },
              separatorBuilder: (_, _) => SizedBox(width: 16.w),
              itemCount: musclesGroupList.length,
            ),
          );
        },
      ),
    );
  }
}

