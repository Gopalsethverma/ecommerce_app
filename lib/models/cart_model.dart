// import 'package:flutter/material.dart';

// class CartModel extends ChangeNotifier {
//   final List<Map<String, dynamic>> _cartItems = [];

//   List<Map<String, dynamic>> get cartItems => _cartItems;

//   void addToCart(Map<String, dynamic> product) {
//     _cartItems.add(product);
//     notifyListeners();
//   }

//   double get totalPrice {
//     return _cartItems.fold(0.0, (sum, item) {
//       double discountedPrice =
//           item['price'] - (item['price'] * item['discountPercentage'] / 100);
//       return sum + discountedPrice;
//     });
//   }
// }

import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> product) {
    final index = _cartItems.indexWhere((item) => item['id'] == product['id']);
    if (index != -1) {
      _cartItems[index]['quantity'] += 1;
    } else {
      product['quantity'] = 1;
      _cartItems.add(product);
    }
    notifyListeners();
  }

  void removeFromCart(Map<String, dynamic> product) {
    _cartItems.removeWhere((item) => item['id'] == product['id']);
    notifyListeners();
  }

  void updateQuantity(Map<String, dynamic> product, int quantity) {
    final index = _cartItems.indexWhere((item) => item['id'] == product['id']);
    if (index != -1) {
      _cartItems[index]['quantity'] = quantity;
      notifyListeners();
    }
  }

  double get totalPrice {
    return _cartItems.fold(0.0, (sum, item) {
      double price = item['price'] ?? 0.0;
      double discountPercentage = item['discountPercentage'] ?? 0.0;
      double discountedPrice = price - (price * discountPercentage / 100);
      int quantity = item['quantity'] ?? 1;
      return sum + (discountedPrice * quantity);
    });
  }
}
