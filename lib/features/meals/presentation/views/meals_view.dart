import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';
import 'package:recipe_finder/core/theme/text_styles.dart';
import 'package:recipe_finder/core/widgets/functions.dart';
import 'package:recipe_finder/features/meals/data/repos/meals_repo.dart';
import 'package:recipe_finder/features/meals/presentation/cubit/meals_cubit.dart';
import 'package:recipe_finder/features/meals/presentation/widgets/meal_card.dart';

class MealsView extends StatelessWidget {
  const MealsView({super.key, required this.categoryName});
  final String categoryName;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MealsCubit(mealsRepo: MealsRepo(categoryName: categoryName))
            ..getMeals(),
      child: BlocConsumer<MealsCubit, MealsState>(
        listener: (context, state) {
          if (state is MealsError) {
            snackBar(
              text: state.errorMessage,
              context: context,
              color: Color(AppColors.errorColor),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.secondaryColor,
              title: Text(
                categoryName,
                style: AppTextStyles.s30Bold.copyWith(fontSize: 18),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back, color: AppColors.primaryColor),
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.search, color: AppColors.darkGray),
                ),
              ],
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    if (state is MealsLoading)
                      Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),

                    SizedBox(height: 20),

                    Expanded(
                      child: state is MealsLoaded
                          ? GridView.builder(
                              itemCount: state.meals.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 0.75,
                                  ),
                              itemBuilder: (context, index) {
                                return MealCard(
                                  image: state.meals[index].mealImage,
                                  title: state.meals[index].mealTitle,
                                  arguments: state.meals[index].mealId,
                                );
                              },
                            )
                          : SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
