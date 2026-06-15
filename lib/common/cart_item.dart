class CartItem {
  String name;
  String image;
  double price;
  int qty;

  CartItem({
    required this.name,
    required this.image,
    required this.price,
    this.qty = 1,
  });
}