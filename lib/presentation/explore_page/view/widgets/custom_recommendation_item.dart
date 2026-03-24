import 'package:elevate_super_fitness/core/constants/widgets_keys.dart';
import 'package:elevate_super_fitness/core/custom_widget/custom_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:elevate_super_fitness/core/utils/screen_util.dart';

class CustomRecommendationItem extends StatelessWidget {
  const CustomRecommendationItem({
    super.key,
    this.width,
    this.height,
    this.border = true,
    this.imagePath,
    this.title,
  });

  final int? width, height;
  final bool border;
  final String? imagePath, title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ClipRRect(
      key: const Key(WidgetsKeys.kExploreScreenRecommendationItemKey),
      borderRadius: BorderRadius.circular(20.r),
      child: AspectRatio(
        aspectRatio: (width != null && height != null)
            ? width! / height!
            : 104 / 104,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CustomCachedNetworkImage(
              imageUrl: imagePath ?? '',
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.4)],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF242424).withOpacity(0.6),
                  borderRadius: border
                      ? BorderRadius.only(
                          topLeft: Radius.circular(20.r),
                          topRight: Radius.circular(20.r),
                        )
                      : BorderRadius.circular(0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  title ?? "",
                  textAlign: TextAlign.center,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSecondary,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

