import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';
import 'package:recipe_finder/core/widgets/functions.dart';
import 'package:recipe_finder/features/home/data/repos/home_repo.dart';
import 'package:recipe_finder/features/home/presentation/cubit/home_cubit.dart';
import 'package:recipe_finder/features/home/presentation/widgets/categories.dart';
import 'package:recipe_finder/features/home/presentation/widgets/home_header.dart';
import 'package:recipe_finder/features/home/presentation/widgets/recipe_card.dart';
import 'package:recipe_finder/features/home/presentation/widgets/search_field.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(homeRepo: HomeRepo())..getCategories(),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {
          if (state is HomeError) {
            snackBar(
              text: state.errorMessage,
              context: context,
              color: Color(AppColors.errorColor),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    if (state is HomeLoading)
                      Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),

                    const SizedBox(height: 20),

                    HomeHeader(),

                    SizedBox(height: 20),

                    SearchField(),

                    SizedBox(height: 20),

                    CategoriesSection(),

                    SizedBox(height: 20),

                    Expanded(
                      child: state is HomeLoaded
                          ? GridView.builder(
                              itemCount: state.categories.length,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 12,
                                    mainAxisSpacing: 12,
                                    childAspectRatio: 0.75,
                                  ),
                              itemBuilder: (context, index) {
                                return RecipeCard(
                                  image: state.categories[index].categoryImage,
                                  title: state.categories[index].categoryTitle,
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
