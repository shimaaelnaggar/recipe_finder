import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';
import 'package:recipe_finder/core/routing/routes.dart';
import 'package:recipe_finder/core/theme/text_styles.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    super.key,
    required this.image,
    required this.title,
    required this.arguments,
  });

  final String image;
  final String title;
  final Object? arguments;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.meals, arguments: arguments);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withAlpha(15),
                blurRadius: 10,
                offset: const Offset(0, 6),
              ),
            ],
          ),

          child: Stack(
            children: [
              Positioned.fill(child: Image.network(image, fit: BoxFit.contain)),

              Positioned(
                bottom: 8,
                left: 8,
                right: 8,
                child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.s18Bold.copyWith(
                    color: AppColors.secondaryColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
