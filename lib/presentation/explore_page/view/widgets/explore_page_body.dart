import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:elevate_super_fitness/core/router/route_names.dart';
import 'package:elevate_super_fitness/generated/l10n.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view/widgets/list_of_recommendation_for_you.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view/widgets/list_of_upcoming_workouts_category.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view/widgets/custom_explore_header_info.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view/widgets/custom_explore_identifier_list.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view/widgets/custom_popular_training_item.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view/widgets/list_of_category.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view/widgets/list_of_recommendation_to_day.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view/widgets/list_of_upcoming_item.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view_model/explore_view_model_cubit.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_events.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class ExplorePageBody extends StatelessWidget {
  final MainHomeViewModel mainHomeViewModel;
  const ExplorePageBody({super.key, required this.mainHomeViewModel});

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context);
    final heightMediaQuery = MediaQuery.of(context).size.height;
    return BlocBuilder<ExploreViewModelCubit, ExploreViewModelState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              const SliverToBoxAdapter(child: CustomExploreHeaderInfo()),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              SliverToBoxAdapter(
                child: CustomExploreIdentifierList(title: local.category),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 8.h)),
              SliverToBoxAdapter(
                child: ListOfCategory(
                  mainHomeViewModel: mainHomeViewModel,
                  key: const Key(WidgetsKeys.kExploreScreenListCategoryItemKey),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              SliverToBoxAdapter(
                child: CustomExploreIdentifierList(
                  title: local.recommendationToDay,
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 8.h)),
              ListOfRecommendationToDay(randomMuscles: state.randomMuscles),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              SliverToBoxAdapter(
                child: CustomExploreIdentifierList(
                  title: local.upcomingWorkouts,
                  onTap: () {
                    context.read<MainHomeViewModel>().doIntent(
                      OnBottomNavBarTappedEvent(index: 2),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 8.h)),
              ListUpcomingWorkoutsCategory(musclesGroup: state.musclesGroup),
              SliverToBoxAdapter(child: SizedBox(height: 8.h)),
              ListOfUpcomingItem(
                musclesGroupDetailsById: state.musclesGroupDetailsById,
              ),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              SliverToBoxAdapter(
                child: CustomExploreIdentifierList(
                  title: local.recommendationForYou,
                  onTap: () {
                    Navigator.of(context).pushNamed(RouteNames.food);
                  },
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 8.h)),
              ListOfRecommendationForYou(mealsCategory: state.mealsCategory),
              SliverToBoxAdapter(child: SizedBox(height: 24.h)),
              SliverToBoxAdapter(
                child: CustomExploreIdentifierList(
                  title: local.popularTraining,
                  onTap: () {},
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 8.h)),
              SliverToBoxAdapter(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: heightMediaQuery * 0.2,
                      ),
                      child: ListView.separated(
                        key: const Key(
                          WidgetsKeys.kExploreScreenListPopularTrainingItemsKey,
                        ),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) =>
                            const CustomPopularTrainingItem(),
                        separatorBuilder: (_, _) => SizedBox(width: 16.w),
                        itemCount: 10,
                      ),
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 40.h)),
            ],
          ),
        );
      },
    );
  }
}

