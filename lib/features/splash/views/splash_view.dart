import 'package:flutter/material.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';
import 'package:recipe_finder/core/constants/app_images.dart';
import 'package:recipe_finder/core/routing/routes.dart';
import 'package:recipe_finder/core/theme/text_styles.dart';
import 'package:recipe_finder/features/splash/widgets/custom_circle.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  @override
  void initState() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..forward();

    animationController.addListener(() => setState(() {}));

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacementNamed(context, Routes.login);
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(gradient: AppColors.gradientColor),
            ),

            Positioned(top: -60, left: -60, child: CustomCircle(size: 256)),

            Positioned(bottom: -80, left: 60, child: CustomCircle(size: 320)),

            Positioned(
              top: 220,
              right: -60,
              child: CustomCircle(
                size: 192,
                color: AppColors.secondaryColor.withAlpha(50),
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.logo,
                  fit: BoxFit.contain,
                  height: 120,
                  width: 96,
                ),
                SizedBox(height: 10),
                Text('Recipe Finder', style: AppTextStyles.s36ExtraBold),
                SizedBox(height: 10),
                Text('COOK WITH PASSION', style: AppTextStyles.s14Meduim),
                SizedBox(height: 50),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 120,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: animationController.value,
                              minHeight: 3,
                              backgroundColor: Colors.white24,
                              valueColor: const AlwaysStoppedAnimation(
                                AppColors.secondaryColor,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 10),

                        const Text(
                          "LOADING KITCHEN",
                          style: AppTextStyles.s12SemiBold,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
