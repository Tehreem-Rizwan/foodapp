class CartItemModel {
  final String imagePath;
  final String name;
  final double price;
  bool isChecked;
  int quantity;

  CartItemModel({
    required this.imagePath,
    required this.name,
    required this.price,
    this.isChecked = false,
    this.quantity = 1,
  });
}
