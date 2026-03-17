class CategoryModel {
  String categoryId;
  String categoryTitle;
  String categoryDesc;
  String categoryImage;
  CategoryModel({
    required this.categoryId,
    required this.categoryTitle,
    required this.categoryDesc,
    required this.categoryImage,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> data) {
    return CategoryModel(
      categoryId: data['idCategory'].toString(),
      categoryTitle: data['strCategory'] ?? '',
      categoryDesc: data['strCategoryDescription'] ?? '',
      categoryImage: data['strCategoryThumb'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': categoryId,
      'title': categoryTitle,
      'desc': categoryDesc,
      'image': categoryImage,
    };
  }
}
