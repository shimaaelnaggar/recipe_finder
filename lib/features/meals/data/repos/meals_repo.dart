import 'package:dartz/dartz.dart';
import 'package:recipe_finder/core/constants/api_constants.dart';
import 'package:recipe_finder/core/services/dio_services.dart';
import 'package:recipe_finder/features/meals/data/models/meal_model.dart';

class MealsRepo {
  final String categoryName;
  List<MealModel> meals = [];

  MealsRepo({required this.categoryName});

  Future<Either<String, List<MealModel>>> getMeals() async {
    try {
      final res = await DioServices.getData(
        endpoint: ApiConstants.mealsEndpoint(categoryName),
      );

      final List mealsJson = res.data['meals'] ?? [];

      meals = mealsJson
          .map((json) => MealModel.fromJson(json))
          .toList();

      return right(meals);
    } catch (e) {
      return left(e.toString());
    }
  }
}