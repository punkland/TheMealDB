import 'package:equatable/equatable.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class FetchMeals extends HomeEvent {
  final String query;

  const FetchMeals({this.query = ''});

  @override
  List<Object?> get props => [query];
}

class LoadMoreMeals extends HomeEvent {}