import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';
import 'package:themealdb/core/theme/app_theme.dart';
import 'package:themealdb/core/utils/app_localizations.dart';
import 'package:themealdb/core/widgets/empty_state_message.dart';
import 'package:themealdb/core/widgets/error_state_message.dart';
import 'package:themealdb/core/widgets/loading_indicator.dart';
import 'package:themealdb/features/recipes/presentation/widgets/recipe_item_card.dart';
import 'package:themealdb/injection_container.dart';
import 'package:themealdb/features/recipes/presentation/bloc/home_bloc.dart';
import 'package:themealdb/features/recipes/presentation/bloc/home_event.dart';
import 'package:themealdb/features/recipes/presentation/bloc/home_state.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController controller = TextEditingController();
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
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<HomeBloc>(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
                title: Text(
              AppLocalizations.of(context).translate('searchRecipes'),
              style: AppTheme.text18w600Mont,
            )),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.sp),
                  child: TextField(
                    controller: controller,
                    textInputAction: TextInputAction.search,
                    decoration: InputDecoration(
                      hintText:
                          AppLocalizations.of(context).translate('example'),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          final query = controller.text.trim();
                          if (query.isNotEmpty) {
                            context
                                .read<HomeBloc>()
                                .add(FetchMeals(query: query));
                          }
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.sp),
                      ),
                    ),
                    onSubmitted: (value) {
                      context.read<HomeBloc>().add(FetchMeals(query: value));
                    },
                  ),
                ),
                Expanded(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is HomeLoading) {
                        return const LoadingIndicator();
                      } else if (state is HomeLoaded) {
                        final hasMore =
                            state.visibleMeals.length < state.allMeals.length;

                        if (state.visibleMeals.isEmpty) {
                          return EmptyStateMessage(
                              message: AppLocalizations.of(context)
                                  .translate('noRecipesFound'));
                        }

                        return ListView.builder(
                          controller: _scrollController,
                          itemCount:
                              state.visibleMeals.length + (hasMore ? 1 : 0),
                          itemBuilder: (_, index) {
                            if (index >= state.visibleMeals.length) {
                              return const Padding(
                                padding: EdgeInsets.symmetric(vertical: 24),
                                child:
                                    Center(child: CircularProgressIndicator()),
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
                      return Center(
                          child: Text(
                        AppLocalizations.of(context).translate('findARecipe'),
                        style: AppTheme.text16Mon,
                      ));
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
