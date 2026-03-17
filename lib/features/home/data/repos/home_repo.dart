import 'package:dartz/dartz.dart';
import 'package:recipe_finder/core/constants/api_constants.dart';
import 'package:recipe_finder/core/services/dio_services.dart';
import 'package:recipe_finder/features/home/data/models/category_model.dart';

class HomeRepo {
  List<CategoryModel> categories = [];

  Future<Either<String, List<CategoryModel>>> getCategories() async {
    try {
      final res = await DioServices.getData(
        endpoint: ApiConstants.categoriesEndpoint,
      );

      final List categoriesJson = res.data['categories'];

      categories = categoriesJson
          .map((json) => CategoryModel.fromJson(json))
          .toList();

      return right(categories);
    } catch (e) {
      return left(e.toString());
    }
  }
}
