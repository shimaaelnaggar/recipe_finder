
import 'package:flutter/material.dart';
import 'package:recipe_finder/core/theme/text_styles.dart';

class CustomText extends StatelessWidget {
  const CustomText({super.key, required this.text});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text, style: AppTextStyles.s14SemiBold);
  }
}
