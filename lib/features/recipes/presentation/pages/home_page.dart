import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themealdb/core/theme/app_theme.dart';
import 'package:themealdb/core/widgets/error_state_message.dart';
import 'package:themealdb/core/widgets/loading_indicator.dart';
import 'package:themealdb/features/recipes/presentation/pages/search_page.dart';
import 'package:themealdb/features/recipes/presentation/widgets/recipe_item_card.dart';
import 'package:themealdb/core/utils/app_localizations.dart';
import 'package:themealdb/features/recipes/presentation/bloc/home_bloc.dart';
import 'package:themealdb/features/recipes/presentation/bloc/home_event.dart';
import 'package:themealdb/features/recipes/presentation/bloc/home_state.dart';
import 'package:themealdb/features/recipes/presentation/pages/favorites_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.addListener(_onScroll);
    });
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 300) {
      context.read<HomeBloc>().add(LoadMoreMeals());
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppLocalizations.of(context).translate('title'),
          style: AppTheme.text18w600Mont,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SearchPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesPage()),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const LoadingIndicator();
          } else if (state is HomeLoaded) {
            final hasMore = state.visibleMeals.length < state.allMeals.length;

            return ListView.builder(
              controller: _scrollController,
              itemCount: state.visibleMeals.length + (hasMore ? 1 : 0),
              itemBuilder: (_, index) {
                if (index >= state.visibleMeals.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                final meal = state.visibleMeals[index];
                return RecipeItemCard(meal: meal);
              },
            );
          } else if (state is HomeError) {
            return ErrorStateMessage(
              message: state.message,
              onRetry: () {
                context.read<HomeBloc>().add(const FetchMeals());
              },
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
