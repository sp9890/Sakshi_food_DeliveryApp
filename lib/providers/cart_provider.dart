import 'package:flutter/material.dart';
import '../common/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _cartItems = [];

  List<CartItem> get cartItems => _cartItems;

  int get totalItems =>
      _cartItems.fold(0, (sum, item) => sum + item.qty);

  double get subTotal =>
      _cartItems.fold(0, (sum, item) => sum + (item.price * item.qty));

  void addItem(CartItem item) {
    int index = _cartItems.indexWhere((e) => e.name == item.name);

    if (index != -1) {
      _cartItems[index].qty++;
    } else {
      _cartItems.add(item);
    }

    notifyListeners();
  }

  void increaseQty(int index) {
    _cartItems[index].qty++;
    notifyListeners();
  }

  void decreaseQty(int index) {
    if (_cartItems[index].qty > 1) {
      _cartItems[index].qty--;
    } else {
      _cartItems.removeAt(index);
    }

    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}