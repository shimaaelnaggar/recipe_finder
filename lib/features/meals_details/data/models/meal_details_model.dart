import 'package:recipe_finder/features/meals_details/data/models/ingredient_model.dart';

class MealDetailsModel {
  final String id;
  final String name;
  final String category;
  final String area;
  final List<String> instructions;
  final String image;
  final String youtube;
  final List<Ingredient> ingredients;

  MealDetailsModel({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.image,
    required this.youtube,
    required this.ingredients,
  });

  factory MealDetailsModel.fromJson(Map<String, dynamic> json) {
    List<Ingredient> ingredientsList = [];

    for (int i = 1; i <= 20; i++) {
      final ingredient = json["strIngredient$i"];
      final measure = json["strMeasure$i"];
      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingredientsList.add(
          Ingredient(
            name: ingredient.toString(),
            measure: measure?.toString() ?? "",
          ),
        );
      }
    }

    final rawInstructions = json["strInstructions"]?.toString() ?? "";
    List<String> instructionsList = rawInstructions
        .split(RegExp(r'\r?\n'))
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    if (instructionsList.isEmpty && rawInstructions.isNotEmpty) {
      instructionsList = [rawInstructions.trim()];
    }

    return MealDetailsModel(
      id: json["idMeal"] ?? "",
      name: json["strMeal"] ?? "",
      category: json["strCategory"] ?? "",
      area: json["strArea"] ?? "",
      instructions: instructionsList,
      image: json["strMealThumb"] ?? "",
      youtube: json["strYoutube"] ?? "",
      ingredients: ingredientsList,
    );
  }
}
