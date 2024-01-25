import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
    this.id,
    this.title,
    this.quantity,
    this.price,
  );
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, product) => total += product.price * product.quantity);
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
          existingCartItem.id,
          existingCartItem.title,
          existingCartItem.quantity + 1,
          existingCartItem.price,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          DateTime.now().toString(),
          title,
          1,
          price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    //easiest way to remove an entry in a map
    //removes the entire item regardless of quantity
    _items.remove(productId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return; //do nothing
    }
    if (_items[productId].quantity > 1) {
      _items.update(
        productId,
        (existingCartItem) => CartItem(
            existingCartItem.id,
            existingCartItem.title,
            existingCartItem.quantity - 1,
            existingCartItem.price),
      );
    }
    else {
      removeItem(productId);
    }
    notifyListeners();
  }
}
