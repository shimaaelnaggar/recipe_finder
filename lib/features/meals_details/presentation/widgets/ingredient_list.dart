import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constants/app_images.dart';
import 'package:recipe_finder/core/theme/text_styles.dart';
import 'package:recipe_finder/features/meals_details/data/models/ingredient_model.dart';

class IngredientsList extends StatelessWidget {
  final List<Ingredient> ingredients;

  const IngredientsList({super.key, required this.ingredients});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: ingredients.map((e) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Image.asset(AppImages.correct),
              ),
              Text(
                " ${e.measure} - ${e.name}",
                style: AppTextStyles.s16Regular.copyWith(fontSize: 14),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
