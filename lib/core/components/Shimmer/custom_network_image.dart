import 'package:flutter/material.dart';
import 'package:movie_explorer/core/components/Shimmer/shimmer_widget.dart';

import '../../../res/assets.dart';

class CustomNetworkImage extends StatelessWidget {
  const CustomNetworkImage({
    super.key,
    required this.image,
    this.height,
    this.width,
    this.alignment = Alignment.center,
    this.fit,
    this.isUserImage = false,
  });

  final String image;
  final double? height;
  final double? width;
  final AlignmentGeometry alignment;
  final BoxFit? fit;
  final bool isUserImage;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      height: height,
      width: width,
      fit: BoxFit.cover,
      alignment: alignment,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return CustomShimmer(
          width: width ?? 0,
          height: height ?? 0,
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          isUserImage ? Assets.pngImageUserPlaceholder : Assets.pngImagePlaceholder,
          width: width,
          height: height,
          fit: fit,
          alignment: Alignment.center,
        );
      },
    );
  }
}
