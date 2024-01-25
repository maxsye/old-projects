import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool
      isFavorite; //not final because should be changeable after the initialization

  Product({
    @required this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false,
  });

  void toggleFavoriteStatus(String id) {
    isFavorite = !isFavorite;
    final url = 'https://shopapp-d135d.firebaseio.com/products/$id.json';
    http.patch(
      url,
      body: json.encode({
        'isFavorite': isFavorite,
      }),
    );
    notifyListeners();
    //equivalent to setState in Stateful widgets
  }
}
