import 'package:flutter/material.dart';
import 'package:recipe_finder/core/theme/text_styles.dart';

class MealInstructions extends StatelessWidget {
  final List<String> steps;
  const MealInstructions({super.key, required this.steps});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: steps.asMap().entries.map((entry) {
        int idx = entry.key + 1;
        String step = entry.value;
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 10,
                backgroundColor: Colors.black,
                child: Text(
                  "$idx",
                  style: AppTextStyles.s18Bold.copyWith(fontSize: 12),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  step,
                  style: AppTextStyles.s16Regular.copyWith(fontSize: 14),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
