import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:themealdb/core/constants/app_constants.dart';
import 'package:themealdb/features/recipes/data/models/meal_model.dart';

abstract class RecipeRemoteDataSource {
  Future<MealModel?> getMealById(String id);
  Future<List<MealModel>> getMeals({String query});
}

class RecipeRemoteDataSourceImpl implements RecipeRemoteDataSource {
  final http.Client client;

  RecipeRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MealModel>> getMeals({String query = ''}) async {
    final url = Uri.parse(
        '${AppConstants.apiBase}${AppConstants.searchUrl}$query');

    final response = await client.get(url);

    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      final mealsJson = decoded['meals'];
      if (mealsJson == null) return []; // no results

      return List<MealModel>.from(
        mealsJson.map((mealJson) => MealModel.fromJson(mealJson)),
      );
    } else {
      throw Exception('Error al cargar recetas');
    }
  }

  @override
  Future<MealModel?> getMealById(String id) async {
    final url = Uri.parse('${AppConstants.apiBase}${AppConstants.lookupUrl}$id');

    final response = await client.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final meals = data['meals'];
      if (meals != null && meals.isNotEmpty) {
        final mealJson = meals[0];
        final model = MealModel.fromJson(mealJson);
        return model;
      }
    }
    return null;
  }
}
