import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';
import 'package:recipe_finder/core/widgets/custom_text_form_field.dart';

class SearchField extends StatelessWidget {
  const SearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      hint: "Search recipes, ingredients...",
      filledColor: true,
      prefixIcon: Icon(Icons.search, color: AppColors.darkGray),
      borderSide: BorderSide.none,
    );
  }
}
