import 'package:themealdb/features/recipes/domain/entities/meal.dart';
import 'package:themealdb/features/recipes/domain/repositories/recipe_repository.dart';

class GetMeals {
  final RecipeRepository repository;

  GetMeals(this.repository);

  Future<List<Meal>> call({String query = ''}) {
    return repository.getMeals(query: query);
  }
}