import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';

class CustomCircle extends StatelessWidget {
  const CustomCircle({super.key, required this.size, this.color});
  final double size;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: color ?? AppColors.secondaryColor.withAlpha(16),
          width: 2,
        ),
      ),
    );
  }
}
