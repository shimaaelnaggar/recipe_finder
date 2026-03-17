import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';
import 'package:recipe_finder/core/theme/text_styles.dart';
import 'package:recipe_finder/features/auth/presentation/widgets/custom_text_button.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Categories",
              style: AppTextStyles.s30Bold.copyWith(fontSize: 18),
            ),
            CustomTextButton(
              text: '',
              onPressed: () {},
              buttonText: 'See All',
              style: AppTextStyles.s12SemiBold.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
