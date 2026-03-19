import 'package:dartz/dartz.dart';
import 'package:recipe_finder/core/constants/api_constants.dart';
import 'package:recipe_finder/core/services/dio_services.dart';
import 'package:recipe_finder/features/meals_details/data/models/meal_details_model.dart';

class MealDetailsRepo {
  final String mealId;

  MealDetailsRepo({required this.mealId});

  Future<Either<String, MealDetailsModel>> getMealDetails() async {
    try {
      final res = await DioServices.getData(
        endpoint: ApiConstants.mealDetailsEndpoint(mealId),
      );

      final data = res.data['meals'];

      if (data == null || data.isEmpty) {
        return left("No meal found");
      }

      final meal = MealDetailsModel.fromJson(data[0]);

      return right(meal);
    } catch (e) {
      return left(e.toString());
    }
  }
}