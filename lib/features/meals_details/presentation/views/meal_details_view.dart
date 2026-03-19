import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:recipe_finder/core/constants/app_colors.dart';
import 'package:recipe_finder/core/services/favourites_services.dart';
import 'package:recipe_finder/core/widgets/custom_button.dart';
import 'package:recipe_finder/core/widgets/functions.dart';
import 'package:recipe_finder/features/meals_details/data/repos/meals_repo.dart';
import 'package:recipe_finder/features/meals_details/presentation/cubit/meals_cubit.dart';
import 'package:recipe_finder/features/meals_details/presentation/widgets/image_info.dart';
import 'package:recipe_finder/features/meals_details/presentation/widgets/meal_image.dart';
import 'package:recipe_finder/features/meals_details/presentation/widgets/meal_instructions.dart';

class MealDetailsView extends StatefulWidget {
  const MealDetailsView({super.key, required this.mealId});
  final String mealId;

  @override
  State<MealDetailsView> createState() => _MealDetailsViewState();
}

class _MealDetailsViewState extends State<MealDetailsView> {
  bool isFav = false;
  @override
  void initState() {
    super.initState();
    isFav = FavoritesService.isFavorite(widget.mealId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MealDetailsCubit(
        mealDetailsRepo: MealDetailsRepo(mealId: widget.mealId),
      )..getMealDetails(),
      child: BlocConsumer<MealDetailsCubit, MealDetailsState>(
        listener: (context, state) {
          if (state is MealDetailsError) {
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Stack(
                  children: [
                    if (state is MealDetailsLoading)
                      Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryColor,
                        ),
                      ),

                    state is MealDetailsLoaded
                        ? SingleChildScrollView(
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16),
                                  ),
                                  child: MealImage(image: state.meal.image),
                                ),
                                Transform.translate(
                                  offset: const Offset(0, -30),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(20),
                                    ),
                                    child: Container(
                                      color: AppColors.secondaryColor,
                                      child: Column(
                                        children: [
                                          MealInfo(meal: state.meal),

                                          const SizedBox(height: 10),

                                          MealInstructions(
                                            steps: state.meal.instructions,
                                          ),

                                          Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: CustomButton(
                                              onPressed: () {},
                                              text: 'Add To Favourites',
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : SizedBox(),
                    Positioned(
                      top: 40,
                      left: 16,
                      child: CircleAvatar(
                        backgroundColor: Colors.black45,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ),

                    Positioned(
                      top: 40,
                      right: 16,
                      child: GestureDetector(
                        onTap: () {
                          if (state is MealDetailsLoaded) {
                            setState(() {
                              FavoritesService.toggleFavorite(widget.mealId, {
                                "id": widget.mealId,
                                "name": state.meal.name,
                                "image": state.meal.image,
                              });

                              isFav = !isFav;
                            });
                          }
                        },
                        child: CircleAvatar(
                          backgroundColor: Colors.black45,
                          child: Icon(
                            isFav ? Icons.favorite : Icons.favorite_border,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
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
