import 'package:awesome_extensions/awesome_extensions.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';
import 'package:readmore/readmore.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../generated/l10n.dart';

class FoodDetailsMealInfo extends StatelessWidget {
  final String imageUrl;
  final String mealName;
  final String mealInstructions;

  const FoodDetailsMealInfo({
    super.key,
    required this.imageUrl,
    required this.mealName,
    required this.mealInstructions,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 340.h,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
            child: CustomCachedNetworkImage(
              imageUrl: imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [.25, 1],
                colors: [
                  AppColors.black.withValues(alpha: 0),
                  AppColors.backGroundL,
                ],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(20.r),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.mainColorL,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  mealName,
                  style: context.bodyLarge?.copyWith(
                    color: AppColors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                GestureDetector(
                  onTap: () {
                    showInstructionsDialog(context);
                  },
                  child: AbsorbPointer(
                    child: ReadMoreText(
                      mealInstructions,
                      trimLines: 2,
                      colorClickableText: AppColors.mainColorL,
                      trimMode: TrimMode.Line,
                      trimCollapsedText:
                          " ${AppLocalizations.of(context).showMore}",
                      style: context.bodyMedium?.copyWith(
                        color: AppColors.white,
                        inherit: true,
                      ),
                      moreStyle: context.bodyMedium?.copyWith(
                        color: AppColors.mainColorL,
                      ),
                      lessStyle: context.bodyMedium?.copyWith(
                        color: AppColors.mainColorL,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildNutritionFacts(
                      context,
                      AppLocalizations.of(context).energy,
                      "100 K",
                    ),
                    buildNutritionFacts(
                      context,
                      AppLocalizations.of(context).protein,
                      "15.6",
                    ),
                    buildNutritionFacts(
                      context,
                      AppLocalizations.of(context).carbs,
                      "58 G",
                    ),
                    buildNutritionFacts(
                      context,
                      AppLocalizations.of(context).fat,
                      "20 G",
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildNutritionFacts(BuildContext context, String title, String value) {
    return Container(
      padding: EdgeInsets.all(8.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: AppColors.white, width: .5.w),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            value,
            style: context.bodySmall?.copyWith(color: AppColors.white),
          ),
          Text(
            title,
            style: context.bodySmall?.copyWith(
              color: AppColors.mainColorL,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  void showInstructionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          backgroundColor: AppColors.backGroundL.withValues(alpha: .8),
          child: Padding(
            padding: EdgeInsets.all(8.sp),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Icon(Icons.close, color: AppColors.white),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      mealInstructions,
                      style: ctx.bodyMedium?.copyWith(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

