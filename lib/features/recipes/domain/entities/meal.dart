import 'package:equatable/equatable.dart';

class Meal extends Equatable {
  final String id;
  final String name;
  final String thumbnail;
  final String category;
  final String area;
  final String? instructions;
  final List<String> ingredients;

  const Meal({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.category,
    required this.area,
    this.instructions,
    this.ingredients = const [],
  });

  @override
  List<Object?> get props => [id, name, thumbnail, category, area, instructions, ingredients];
}