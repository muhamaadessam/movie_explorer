import 'package:flutter/material.dart';

import '../../../../core/components/Shimmer/shimmer_widget.dart';

class MovieCardShimmer extends StatelessWidget {
  const MovieCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomShimmer(width: double.infinity, height: 170.0);
  }
}
