import 'package:themealdb/features/recipes/domain/entities/meal.dart';
import 'package:themealdb/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:themealdb/features/recipes/data/datasources/recipe_remote_data_source.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeRemoteDataSource remoteDataSource;

  RecipeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<Meal>> getMeals({String query = ''}) async {
    final mealModels = await remoteDataSource.getMeals(query: query);
    return mealModels.map((model) => model.toEntity()).toList();
  }

  @override
  Future<Meal?> getMealById(String id) async {
    final model = await remoteDataSource.getMealById(id);
    return model?.toEntityFromJson();
  }
}
