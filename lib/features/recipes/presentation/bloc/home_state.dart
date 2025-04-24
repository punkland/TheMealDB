import 'package:equatable/equatable.dart';
import 'package:themealdb/features/recipes/domain/entities/meal.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Meal> allMeals;
  final List<Meal> visibleMeals;

  const HomeLoaded({required this.allMeals, required this.visibleMeals});

  @override
  List<Object?> get props => [allMeals, visibleMeals];

  HomeLoaded copyWith({List<Meal>? visibleMeals}) {
    return HomeLoaded(
      allMeals: allMeals,
      visibleMeals: visibleMeals ?? this.visibleMeals,
    );
  }
}

class HomeError extends HomeState {
  final String message;

  const HomeError(this.message);

  @override
  List<Object?> get props => [message];
}