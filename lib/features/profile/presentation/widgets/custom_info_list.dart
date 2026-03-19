import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';
import 'package:recipe_finder/core/theme/text_styles.dart';

class CustomInfoList extends StatelessWidget {
  const CustomInfoList({
    super.key,
    required this.icon,
    required this.text,
    this.onTap,
  });
  final IconData icon;
  final String text;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Color(0xff94A3B8).withAlpha(30),
      ),

      child: ListTile(
        leading: Container(
          width: 32,
          height: 32,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: AppColors.primaryColor.withAlpha(60),
          ),
          child: Center(
            child: Icon(icon, color: AppColors.primaryColor, size: 16),
          ),
        ),
        title: Text(text, style: AppTextStyles.s11Meduim),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Color(0xff94A3B8),
        ),
        onTap: onTap,
      ),
    );
  }
}
