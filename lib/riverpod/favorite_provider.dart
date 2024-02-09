import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:figma_practice/models/meal.dart';

class FavoriteNotifier extends StateNotifier<List<Meal>> {
  FavoriteNotifier() : super([]);

  void addFavorite(Meal meal) {
    Meal checkFavrite = state.firstWhere(
      (chMeal) => chMeal.id == meal.id,
      orElse: () => Meal(
        id: 'yyy',
        title: 'title',
        details: 'details',
        categoryId: 'categoryId',
        price: 55,
        imageUrl: 'imageUrl',
        frequency: 1,
      ),
    );
    final isFavorite = state.contains((checkFavrite));

    if (isFavorite) {
      state = state.where((fmeal) => fmeal.id != meal.id).toList();
    } else {
      state = [...state, meal];
    }
  }
}

var favoriteMealProvider = StateNotifierProvider<FavoriteNotifier, List<Meal>>(
    (ref) => FavoriteNotifier());
