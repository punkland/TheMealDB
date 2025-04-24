import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themealdb/features/recipes/domain/usecases/get_meals.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetMeals getMeals;

  HomeBloc(this.getMeals) : super(HomeInitial()) {
    on<FetchMeals>(_onFetchMeals);
    on<LoadMoreMeals>(_onLoadMoreMeals);
  }

  static const _pageSize = 8;

  Future<void> _onFetchMeals(FetchMeals event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    try {
      final meals = await getMeals(query: event.query);
      emit(HomeLoaded(
        allMeals: meals,
        visibleMeals: meals.take(_pageSize).toList(),
      ));
    } catch (_) {
      emit(HomeError('Error al cargar recetas.'));
    }
  }

  void _onLoadMoreMeals(LoadMoreMeals event, Emitter<HomeState> emit) {
    final state = this.state;
    if (state is HomeLoaded) {
      final currentLength = state.visibleMeals.length;
      final nextMeals = state.allMeals.skip(currentLength).take(_pageSize).toList();

      if (nextMeals.isNotEmpty) {
        emit(state.copyWith(
          visibleMeals: [...state.visibleMeals, ...nextMeals],
        ));
      }
    }
  }
}