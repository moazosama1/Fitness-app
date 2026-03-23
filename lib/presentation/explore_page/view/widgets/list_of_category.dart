import 'dart:ui';
import 'package:elevate_super_fitness/core/constants/app_colors.dart';
import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view/widgets/custom_category_item.dart';
import 'package:elevate_super_fitness/presentation/explore_page/view_model/explore_view_model_cubit.dart';
import 'package:elevate_super_fitness/presentation/main_home/view_model/main_home_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class ListOfCategory extends StatelessWidget {
  final MainHomeViewModel mainHomeViewModel;
  const ListOfCategory({super.key,required this.mainHomeViewModel});

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<ExploreViewModelCubit>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 34.6, sigmaY: 34.6),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xff242424).withOpacity(0.8),
            borderRadius: BorderRadius.circular(20.r),
          ),
          child: Padding(
            key: const Key(WidgetsKeys.kExploreScreenCategoryItemKey),
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
            child: Row(
              children: List.generate(cubit.categories.length, (index) {
                final category = cubit.categories[index];
                return Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CustomCategoryItem(
                          imagePath: category['image']!,
                          title: category['title']!,
                          lastItem: index == 4 ,
                          mainHomeViewModel: mainHomeViewModel,
                        ),
                      ),
                      if (index < cubit.categories.length - 1)
                        Container(
                          width: 1,
                          height: 80,
                          color: AppColors.backGroundL[20],
                        ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

