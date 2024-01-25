import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(this.id, this.amount, this.products, this.dateTime);
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const url = 'https://shopapp-d135d.firebaseio.com/orders.json';
    final timestamp = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'amount': total,
        'dateTime': DateTime.now().toIso8601String(),
        'products': cartProducts
            .map((cartItem) => {
                  'id': cartItem.id,
                  'title': cartItem.title,
                  'quantity': cartItem.quantity,
                  'double': cartItem.price,
                })
            .toList(),
      }),
    );

    //.add adds at the end of the list
    //.insert(0, etc) adds at index 0
    _orders.insert(
      0,
      OrderItem(
        json.decode(response.body)['name'],
        total,
        cartProducts,
        timestamp,
      ),
    );
    notifyListeners();
  }

  Future<void> fetchAndSetOrders() async {
    const url = 'https://shopapp-d135d.firebaseio.com/orders.json';
    final response = await http.get(url);
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null)
    {
      return;
    }
    final List<OrderItem> _loadedOrders = [];
    extractedData.forEach((key, value) {
      _loadedOrders.add(
        OrderItem(
          key,
          value['amount'],
          (value['products'] as List<dynamic>)
              .map(
                (item) => CartItem(
                  item['id'],
                  item['title'],
                  item['quantity'],
                  item['price'],
                ),
              )
              .toList(),
          DateTime.parse(value['dateTime']
              //DateTime.parse only works with .toIso8601String()
              ),
        ),
      );
    });
    _orders = _loadedOrders.reversed.toList();
    notifyListeners();
  }
}
