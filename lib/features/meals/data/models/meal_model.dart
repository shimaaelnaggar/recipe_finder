class MealModel {
  String mealId;
  String mealTitle;
  String mealImage;
  MealModel({
    required this.mealId,
    required this.mealTitle,
    required this.mealImage,
  });

  factory MealModel.fromJson(Map<String, dynamic> data) {
    return MealModel(
      mealId: data['idMeal'].toString(),
      mealTitle: data['strMeal'] ?? '',
      mealImage: data['strMealThumb'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': mealId, 'title': mealTitle, 'image': mealImage};
  }
}
