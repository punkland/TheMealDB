import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:themealdb/core/theme/app_theme.dart';
import 'package:themealdb/core/utils/app_utils.dart';
import 'package:themealdb/features/recipes/domain/entities/meal.dart';
import 'package:themealdb/features/recipes/presentation/pages/recipe_detail_page.dart';

class RecipeItemCard extends StatelessWidget {
  final Meal meal;

  const RecipeItemCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            AppUtils.createFadeScaleRoute(RecipeDetailPage(meal: meal)),
          );
        },
        child: Hero(
          tag: meal.id,
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: [
                Image.network(meal.thumbnail,
                    width: 40.sp, height: 40.sp, fit: BoxFit.cover),
                SizedBox(width: 5.w),
                Expanded(
                  child: Padding(
                    padding:  EdgeInsets.symmetric(vertical: 1.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          meal.name,
                          style: AppTheme.text16w600Mon,
                        ),
                        SizedBox(height: 1.h),
                        Text('${meal.category} • ${meal.area}',
                            style: AppTheme.text14W400Black),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
