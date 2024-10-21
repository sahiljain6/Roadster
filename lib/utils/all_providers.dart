import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:roadster/components/models/product.dart';
import 'package:roadster/screens/tab_screens/home.dart';
import 'package:roadster/utils/app_state.dart';

class CounterNotifier extends StateNotifier<List<int>> {
  CounterNotifier() : super(AppState.counter);

  void addCount(Product item) {
    int index = allProducts.indexWhere((element) => element.id == item.id);
    state[index] = state[index] + 1;
  }

  void subCount(Product item) {
    int index = allProducts.indexWhere((element) => element.id == item.id);
    state[index] = state[index] - 1;
  }

  void resetCount(Product item) {
    int index = allProducts.indexWhere((element) => element.id == item.id);
    state[index] = 0;
  }
}

final counterProvider = StateNotifierProvider<CounterNotifier, List<int>>(
    (ref) => CounterNotifier());

class CartNotifier extends StateNotifier<List<Product>> {
  CartNotifier() : super(AppState.cartProducts);

  void addCart(Product item) {
    state = [...state, item];
  }

  void removeCart(Product item) {
    state = state.where((element) => item.id != element.id).toList();
  }

  void resetCart() {
    state = [];
  }
}

final cartProvider =
    StateNotifierProvider<CartNotifier, List<Product>>((ref) => CartNotifier());

class FavNotifier extends StateNotifier<List<Product>> {
  FavNotifier() : super(AppState.favProducts);

  void addFav(Product item) {
    state = [...state, item];
  }

  void removeFav(Product item) {
    state = state.where((element) => item.id != element.id).toList();
  }
}

final favProvider =
    StateNotifierProvider<FavNotifier, List<Product>>((ref) => FavNotifier());
