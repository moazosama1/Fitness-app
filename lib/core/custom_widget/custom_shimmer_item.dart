import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';
import 'package:shimmer/shimmer.dart';

Widget buildShimmerList(double height, double? width) {
  return LayoutBuilder(
    builder: (context, constraints) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: height),
        child: Shimmer.fromColors(
          baseColor: Colors.white.withOpacity(0.15),
          highlightColor: Colors.white.withOpacity(0.35),
          period: const Duration(milliseconds: 1200),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            separatorBuilder: (_, _) => SizedBox(width: 16.w),
            itemBuilder: (context, index) => Container(
              width: width ?? 104.w,
              height: height,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20.r),
              ),
            ),
          ),
        ),
      );
    },
  );
}

Widget buildShimmerCategoryItemList(double height) {
  return ConstrainedBox(
    constraints: BoxConstraints(maxHeight: height * 0.045),
    child: Shimmer.fromColors(
      baseColor: Colors.white.withOpacity(0.15),
      highlightColor: Colors.white.withOpacity(0.35),
      direction: ShimmerDirection.ltr,
      period: const Duration(milliseconds: 1200),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        itemCount: 6,
        separatorBuilder: (_, _) => SizedBox(width: 16.w),
        itemBuilder: (context, index) => Container(
          width: 80.w,
          height: height * 0.045,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      ),
    ),
  );
}

Widget buildShimmerGridWorkoutsItems() {
  return Padding(
    padding: EdgeInsets.all(16.sp),
    child: GridView.builder(
      itemCount: 6,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.white.withOpacity(0.15),
          highlightColor: Colors.white.withOpacity(0.35),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
        );
      },
    ),
  );
}

Widget buildShimmerMainProfileItem() {
  return Shimmer.fromColors(
    baseColor: Colors.white.withOpacity(0.15),
    highlightColor: Colors.white.withOpacity(0.35),
    child: Column(
      children: [
        // Circular image shimmer
        ClipOval(
          child: Container(
            width: 100.w,
            height: 100.h,
            color: Colors.grey.shade300,
          ),
        ),
        SizedBox(height: 8.h),

        // Text shimmer
        Container(
          width: 120.w,
          height: 16.h,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
      ],
    ),
  );
}

Widget buildShimmerEditImage() {
  return Shimmer.fromColors(
    baseColor: Colors.white.withOpacity(0.15),
    highlightColor: Colors.white.withOpacity(0.35),
    child: ClipOval(
      child: Container(
        width: 100.w,
        height: 100.h,
        color: Colors.grey.shade300,
      ),
    ),
  );
}

