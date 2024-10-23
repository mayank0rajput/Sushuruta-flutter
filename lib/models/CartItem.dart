class CartItem {
  final int itemId;
  final int quantity;
  final int price;

  CartItem({required this.itemId, required this.quantity, required this.price});
  // Factory constructor to create an Item from a JSON map
  factory CartItem.fromJson(Map<String, dynamic> json) {
    return CartItem(
      itemId: json['item-id'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
}