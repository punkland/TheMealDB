import 'package:flutter/material.dart';
import 'package:themealdb/core/constants/app_constants.dart';
import 'package:themealdb/core/theme/app_theme.dart';
import 'package:themealdb/core/utils/app_localizations.dart';
import 'package:themealdb/features/recipes/presentation/widgets/recipe_item_card.dart';
import 'package:themealdb/core/storage/favorites_storage.dart';
import 'package:themealdb/injection_container.dart';
import 'package:themealdb/features/recipes/domain/entities/meal.dart';
import 'package:themealdb/features/recipes/domain/repositories/recipe_repository.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Meal> favorites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final storage = sl<FavoritesStorage>();
    final ids = await storage.getFavorites();

    final repo = sl<RecipeRepository>();
    final meals = await Future.wait(ids.map((id) => repo.getMealById(id)));

    setState(() {
      favorites = meals.whereType<Meal>().toList();
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        AppLocalizations.of(context).translate('favorites'),
        style: AppTheme.text18w600Mont,
      )),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : favorites.isEmpty
                ? Center(
                    key: ValueKey(AppConstants.emptyKey),
                    child: Text(
                      AppLocalizations.of(context)
                          .translate('thereAreNotFavorites'),
                      style: AppTheme.text16Mon,
                    ),
                  )
                : ListView.builder(
                    key: const ValueKey(AppConstants.listKey),
                    itemCount: favorites.length,
                    itemBuilder: (_, index) {
                      final meal = favorites[index];
                      return RecipeItemCard(meal: meal);
                      ;
                    },
                  ),
      ),
    );
  }
}
