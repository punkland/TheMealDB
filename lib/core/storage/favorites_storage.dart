import 'package:shared_preferences/shared_preferences.dart';
import 'package:themealdb/core/constants/app_constants.dart';

class FavoritesStorage {
  static const _key = AppConstants.favoriteKey;

  Future<List<String>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_key) ?? [];
  }

  Future<void> toggleFavorite(String mealId) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getStringList(_key) ?? [];

    if (current.contains(mealId)) {
      current.remove(mealId);
    } else {
      current.add(mealId);
    }

    await prefs.setStringList(_key, current);
  }

  Future<bool> isFavorite(String mealId) async {
    final favorites = await getFavorites();
    return favorites.contains(mealId);
  }
}
