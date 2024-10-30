class CartItemModel {
  String imagePath;
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

  Map<String, dynamic> toJson() {
    return {
      'imagePath': imagePath,
      'name': name,
      'price': price,
      'isChecked': isChecked,
      'quantity': quantity,
    };
  }
}
