import 'package:flutter/material.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final BoxFit? fit;
  final Color? color;

  const CustomCachedNetworkImage({
    super.key,
    required this.imageUrl,
    this.height,
    this.width,
    this.fit,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    if (!imageUrl.startsWith('assets/')) {
      return const Icon(Icons.broken_image);
    }

    return Image.asset(
      imageUrl,
      height: height,
      width: width,
      fit: fit,
      color: color,
      cacheWidth: 208,
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
    );
  }
}
