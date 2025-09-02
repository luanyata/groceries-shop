import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List _shopItems = [
    // [itemName, itemPrice, imagePath, color]
    ["Avocado", "4.00", "lib/images/abacate.png", Colors.green],
    ["Banana", "2.00", "lib/images/banana.png", Colors.yellow],
    ["Strawberry", "4.50", "lib/images/morango.png", Colors.red],
    ["Grapes", "3.00", "lib/images/uva.png", Colors.purple],
    ["Watermelon", "5.00", "lib/images/melancia.png", Colors.green],
  ];

  // List cart items
  final List _cartItems = [];

  get shopItems => _shopItems;
  get cartItems => _cartItems;

  // Add item to cart
  void addToCart(int index) {
    _cartItems.add(_shopItems[index]);
    notifyListeners();
  }

  // Remove item from cart
  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  // Calculate total price
  double getTotalPrice() {
    return _cartItems.fold(0, (total, item) => total + double.parse(item[1]));
  }

  // Clear cart
  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
