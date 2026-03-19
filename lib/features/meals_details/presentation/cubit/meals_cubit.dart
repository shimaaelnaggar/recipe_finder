import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:recipe_finder/features/meals_details/data/models/meal_details_model.dart';
import 'package:recipe_finder/features/meals_details/data/repos/meals_repo.dart';
part 'meals_state.dart';

class MealDetailsCubit extends Cubit<MealDetailsState> {
  final MealDetailsRepo mealDetailsRepo;

  MealDetailsCubit({required this.mealDetailsRepo})
    : super(MealDetailsInitial());

  Future<void> getMealDetails() async {
    emit(MealDetailsLoading());

    final res = await mealDetailsRepo.getMealDetails();

    res.fold(
      (error) => emit(MealDetailsError(errorMessage: error)),
      (meal) => emit(MealDetailsLoaded(meal: meal)),
    );
  }
}
