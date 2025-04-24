import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:themealdb/core/constants/app_constants.dart';
import 'package:themealdb/core/storage/favorites_storage.dart';
import 'package:themealdb/core/theme/app_theme.dart';
import 'package:themealdb/core/utils/app_localizations.dart';
import 'package:themealdb/injection_container.dart';
import 'package:themealdb/features/recipes/domain/entities/meal.dart';
import 'package:themealdb/features/recipes/domain/repositories/recipe_repository.dart';

class RecipeDetailPage extends StatefulWidget {
  final Meal meal;

  const RecipeDetailPage({super.key, required this.meal});

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  late Meal currentMeal;
  bool isFav = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    currentMeal = widget.meal;
    _loadFullMeal();
    _loadFavorite();
  }

  Future<void> _loadFullMeal() async {
    final repo = sl<RecipeRepository>();
    final fullMeal = await repo.getMealById(widget.meal.id);
    if (fullMeal != null) {
      setState(() {
        currentMeal = fullMeal;
        isLoading = false;
      });
    }
  }

  Future<void> _loadFavorite() async {
    final favStorage = sl<FavoritesStorage>();
    final fav = await favStorage.isFavorite(widget.meal.id);
    setState(() => isFav = fav);
  }

  Future<void> _toggleFavorite() async {
    final favStorage = sl<FavoritesStorage>();
    await favStorage.toggleFavorite(widget.meal.id);
    _loadFavorite();
  }

  @override
  Widget build(BuildContext context) {
    final meal = currentMeal;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          meal.name,
          style: AppTheme.text18w600Mont,
        ),
        actions: [
          IconButton(
            icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: meal.id,
                    child: Image.network(
                      meal.thumbnail,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meal.name,
                          style: AppTheme.text18600Pop,
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          '${meal.category} • ${meal.area}',
                          style: AppTheme.text16500Pop,
                        ),
                        SizedBox(height: 1.5.h),
                        Text(
                            AppLocalizations.of(context)
                                .translate('instructions'),
                            style: AppTheme.text18600Pop
                                .copyWith(color: AppTheme.orange)),
                        SizedBox(height: 0.5.h),
                        Text(
                          meal.instructions ??
                              AppLocalizations.of(context)
                                  .translate('noInstructionsAvailable'),
                          style: AppTheme.text16500Pop,
                        ),
                        SizedBox(height: 3.h),
                        if (meal.ingredients.isNotEmpty)
                          Text(
                              AppLocalizations.of(context)
                                  .translate('ingredients'),
                              style: AppTheme.text18600Pop
                                  .copyWith(color: AppTheme.orange)),
                        ...meal.ingredients
                            .map((i) => Text(
                                  '${AppConstants.dash} $i',
                                  style: AppTheme.text16500Pop,
                                ))
                            .toList(),
                      ],
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
