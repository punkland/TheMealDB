import 'package:json_annotation/json_annotation.dart';
import 'package:themealdb/features/recipes/domain/entities/meal.dart';

part 'meal_model.g.dart';

@JsonSerializable()
class MealModel {
  @JsonKey(name: 'idMeal')
  final String id;

  @JsonKey(name: 'strMeal')
  final String name;

  @JsonKey(name: 'strMealThumb')
  final String thumbnail;

  @JsonKey(name: 'strCategory')
  final String category;

  @JsonKey(name: 'strArea')
  final String area;

  @JsonKey(ignore: true)
  Map<String, dynamic>? originalJson;

  MealModel({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.category,
    required this.area,
    this.originalJson,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    final model = _$MealModelFromJson(json);
    model.originalJson = json;
    return model;
  }

  Map<String, dynamic> toJson() => _$MealModelToJson(this);

  Meal toEntity() => Meal(
    id: id,
    name: name,
    thumbnail: thumbnail,
    category: category,
    area: area,
  );

  Meal toEntityFromJson() {
    final json = originalJson;
    if (json == null) {
      print('❗ originalJson es null');
      return toEntity();
    }

    return Meal(
      id: id,
      name: name,
      thumbnail: thumbnail,
      category: category,
      area: area,
      instructions: json['strInstructions'] ?? 'Sin instrucciones',
      ingredients: getIngredients(json),
    );
  }

  List<String> getIngredients(Map<String, dynamic> json) {
    final ingredients = <String>[];
    for (int i = 1; i <= 20; i++) {
      final name = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (name != null && name.toString().trim().isNotEmpty) {
        ingredients.add('$name ${measure ?? ''}'.trim());
      }
    }
    return ingredients;
  }
}