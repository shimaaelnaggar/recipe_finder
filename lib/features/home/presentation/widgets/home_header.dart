import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';
import 'package:recipe_finder/core/theme/text_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Recipe Finder",
          style: AppTextStyles.s30Bold.copyWith(fontSize: 20),
        ),
        IconButton(
          icon: Icon(Icons.search, color: AppColors.primaryColor, size: 24),
          onPressed: () {},
        ),
      ],
    );
  }
}
