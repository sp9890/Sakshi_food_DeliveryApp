import 'cart_item.dart';

class CartService {
  static List<CartItem> cartItems = [];

  static void addItem(CartItem item) {
    int index = cartItems.indexWhere(
      (e) => e.name == item.name,
    );

    if (index != -1) {
      cartItems[index].qty++;
    } else {
      cartItems.add(item);
    }
  }

  static void increaseQty(int index) {
    cartItems[index].qty++;
  }

  static void decreaseQty(int index) {
    if (cartItems[index].qty > 1) {
      cartItems[index].qty--;
    } else {
      cartItems.removeAt(index);
    }
  }
}