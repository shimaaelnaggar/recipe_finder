import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';
import 'package:recipe_finder/core/widgets/custom_text_form_field.dart';

class SearchField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  const SearchField({super.key, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      hint: "Search recipes, ingredients...",
      filledColor: true,
      prefixIcon: Icon(Icons.search, color: AppColors.darkGray),
      borderSide: BorderSide.none,
      onChanged: onChanged,
    );
  }
}
