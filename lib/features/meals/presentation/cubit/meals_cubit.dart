import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:recipe_finder/features/meals/data/models/meal_model.dart';
import 'package:recipe_finder/features/meals/data/repos/meals_repo.dart';
part 'meals_state.dart';

class MealsCubit extends Cubit<MealsState> {
  final MealsRepo mealsRepo;

  MealsCubit({required this.mealsRepo}) : super(MealsInitial());

  Future<void> getMeals() async {
    emit(MealsLoading());

    try {
      final res = await mealsRepo.getMeals();
      res.fold(
        (error) {
          emit(MealsError(errorMessage: error));
        },
        (meals) {
          emit(MealsLoaded(meals: meals));
        },
      );
    } catch (e) {
      emit(MealsError(errorMessage: e.toString()));
    }
  }
}
