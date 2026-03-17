import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';
import 'package:recipe_finder/core/theme/text_styles.dart';

class SocialMediaSection extends StatelessWidget {
  const SocialMediaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Divider(
                color: AppColors.dividerColor,
                thickness: 1,
                endIndent: 10,
              ),
            ),
            Text(
              'Or SignUp With',
              style: AppTextStyles.s16Regular.copyWith(fontSize: 14),
            ),
            Expanded(
              child: Divider(
                color: AppColors.dividerColor,
                thickness: 1,
                indent: 10,
              ),
            ),
          ],
        ),
        SizedBox(height: 20),

        Row(
          children: [
            createCustomSocialButton(text: 'Google'),

            SizedBox(width: 12),
            createCustomSocialButton(text: 'Apple'),
          ],
        ),
      ],
    );
  }

  Expanded createCustomSocialButton({
    void Function()? onPressed,
    required String text,
  }) {
    return Expanded(
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Text(
          text,
          style: AppTextStyles.s14SemiBold.copyWith(fontSize: 16),
        ),
      ),
    );
  }
}
