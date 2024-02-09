import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:figma_practice/models/meal.dart';

class CartNotifier extends StateNotifier<List<Meal>> {
  CartNotifier() : super([]);

  void addToCart(Meal meal) {
    state = [...state, meal];
  }

  void updateCartList(List<Meal> meals) {
    state = [...meals];
  }

  void removeFromCart(Meal meal) {
    final Meal mealToBeRemoved =
        state.firstWhere((cartMeal) => cartMeal.id == meal.id);
    state = state.where((cartMeal) => cartMeal != mealToBeRemoved).toList();
  }
}

final cartProvider =
    StateNotifierProvider<CartNotifier, List<Meal>>((ref) => CartNotifier());
