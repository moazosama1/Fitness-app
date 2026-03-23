import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:elevate_super_fitness/presentation/food/view/widget/food_tab_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/custom_widget/custom_dialog.dart';
import '../../../../generated/l10n.dart';
import '../../view_model/food_events.dart';
import '../../view_model/food_view_model.dart';
import 'food_tab_bar.dart';

class FoodViewBody extends StatefulWidget {
  final int categoryIndex;
  const FoodViewBody({super.key, required this.categoryIndex});

  @override
  State<FoodViewBody> createState() => _FoodViewBodyState();
}

class _FoodViewBodyState extends State<FoodViewBody>
    with TickerProviderStateMixin {
  late final FoodViewModel _foodViewModel;
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _foodViewModel = context.read<FoodViewModel>();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 24.w,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mainColorL,
                  ),
                  padding: const EdgeInsets.all(1),
                  child: Icon(
                    Icons.arrow_back_ios_new_outlined,
                    color: AppColors.white,
                  ),
                ),
              ),
              Text(
                AppLocalizations.of(context).foodRecommendation,
                style: context.bodyLarge?.copyWith(
                  color: AppColors.white,
                  fontSize: 24.sp,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: BlocConsumer<FoodViewModel, FoodState>(
            bloc: _foodViewModel,
            listener: (context, state) {
              if (state.errorMessage != null) {
                CustomDialog.fitnessPositiveButton(
                  context: context,
                  message: state.errorMessage!,
                );
              }
            },
            builder: (context, state) {
              if (state.mealsCategoriesList != null &&
                  state.mealsCategoriesList!.isNotEmpty) {
                initTabBar(
                  state.mealsCategoriesList!.length,
                  index: widget.categoryIndex,
                );
                return Column(
                  children: [
                    FoodTabBar(
                      mealsCategoriesList:
                          _foodViewModel.state.mealsCategoriesList!,
                      tabController: _tabController!,
                    ),
                    SizedBox(height: 24.h),
                    ?const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    ).showIf(state.isMealsLoading),
                    ?Expanded(
                      child: Center(
                        child: Text(
                          AppLocalizations.of(context).noMealsAvailable,
                          style: context.bodyMedium?.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ).showIf(
                      state.isMealsLoading == false && state.mealsList!.isEmpty,
                    ),
                    ?Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: state.mealsCategoriesList!.map((_) {
                          return FoodTabBarView(
                            mealsList: _foodViewModel.state.mealsList ?? [],
                          );
                        }).toList(),
                      ),
                    ).showIf(
                      !state.isMealsLoading &&
                          state.mealsList != null &&
                          state.mealsList!.isNotEmpty,
                    ),
                  ],
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }

  void initTabBar(int length, {int? index}) {
    if (_tabController == null || _tabController!.length != length) {
      _tabController?.dispose();
      _tabController = TabController(length: length, vsync: this);

      _tabController!.addListener(() {
        if (_tabController!.indexIsChanging) return;
        context.read<FoodViewModel>().doIntent(
          ChangeTabAndGetMealsFoodEvent(_tabController!.index),
        );
      });

      if (index != null) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (_tabController!.index != index) {
            _tabController!.animateTo(index);
          }
        });
      }
    }
  }
}

