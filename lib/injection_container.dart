import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:themealdb/core/storage/favorites_storage.dart';
import 'package:themealdb/features/recipes/data/datasources/recipe_remote_data_source.dart';
import 'package:themealdb/features/recipes/data/repositories/recipe_repository_impl.dart';
import 'package:themealdb/features/recipes/domain/repositories/recipe_repository.dart';
import 'package:themealdb/features/recipes/domain/usecases/get_meals.dart';
import 'package:themealdb/features/recipes/presentation/bloc/home_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Data sources
  sl.registerLazySingleton<RecipeRemoteDataSource>(
    () => RecipeRemoteDataSourceImpl(client: sl()),
  );

  // Repositories
  sl.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(remoteDataSource: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetMeals(sl()));

  // External
  sl.registerLazySingleton(() => http.Client());

  sl.registerFactory(() => HomeBloc(sl()));
  sl.registerLazySingleton(() => FavoritesStorage());
}
