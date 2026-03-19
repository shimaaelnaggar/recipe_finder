class ApiConstants {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1/';
  static const String categoriesEndpoint = 'categories.php';

  static String mealsEndpoint(String categoryName) => 'filter.php?c=$categoryName';
  static String mealDetailsEndpoint(String mealId) => 'lookup.php?i=$mealId';
}