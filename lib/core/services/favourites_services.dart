import 'package:hive/hive.dart';

class FavoritesService {
  static final box = Hive.box('favorites');

  static void toggleFavorite(String id, Map data) {
    if (box.containsKey(id)) {
      box.delete(id);
    } else {
      box.put(id, data);
    }
  }

  static bool isFavorite(String id) {
    return box.containsKey(id);
  }

  static List getFavorites() {
    return box.values.toList();
  }
}
