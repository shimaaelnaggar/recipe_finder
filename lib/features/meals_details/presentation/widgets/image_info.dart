import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';
import 'package:recipe_finder/core/theme/text_styles.dart';
import 'package:recipe_finder/features/meals_details/data/models/meal_details_model.dart';
import 'package:recipe_finder/features/meals_details/presentation/widgets/ingredient_list.dart';

class MealInfo extends StatelessWidget {
  final MealDetailsModel meal;

  const MealInfo({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withAlpha(60),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                meal.category.toUpperCase(),
                style: AppTextStyles.s12SemiBold.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          Text(meal.name, style: AppTextStyles.s30Bold.copyWith(fontSize: 24)),

          const SizedBox(height: 20),

          Text(
            "Ingredients",
            style: AppTextStyles.s30Bold.copyWith(fontSize: 18),
          ),

          const SizedBox(height: 10),

          IngredientsList(ingredients: meal.ingredients),

          const SizedBox(height: 20),
          Text(
            "Instructions",
            style: AppTextStyles.s30Bold.copyWith(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
