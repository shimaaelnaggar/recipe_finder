import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';
import 'package:recipe_finder/core/theme/text_styles.dart';

import 'dart:math';

class MealCard extends StatelessWidget {
  MealCard({super.key, required this.image, required this.title});

  final String image;
  final String title;

  final random = Random();
  String get time => "${15 + random.nextInt(45)} min";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: AppColors.secondaryColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(15),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 140,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(image, fit: BoxFit.cover),
                  ),
                ),
              ],
            ),

            // Title with padding
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.s14SemiBold,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.timelapse),
                      SizedBox(width: 4),
                      Text(time, style: AppTextStyles.s11Meduim),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
