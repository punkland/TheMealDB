import 'package:themealdb/features/recipes/domain/entities/meal.dart';

abstract class RecipeRepository {
  Future<List<Meal>> getMeals({String query});
  Future<Meal?> getMealById(String id);
}