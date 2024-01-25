import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'
    as http; //avoid name clashes, use features from this package through http.

import '../models/http_exception.dart';
import './product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items]; //return a copy of _items, so that when other
    //classes will not have direct access through the pointer and will
    //not be able to edit _items
    //also, when _items updates, we need to call a method to tell
    //the listeners that new data is available
  }

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  Product findByID(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  // void showFavoritesOnly() {
  //   _showFavoritesOnly = true;
  //   notifyListeners();
  // }

  // void showAll() {
  //   _showFavoritesOnly = false;
  //   notifyListeners();
  // }

  Future<void> addProduct1(Product product) {
    //the Future data will resolve to void, we don't need to pass any data back
    //http requests take time to finish
    const url = 'https://shopapp-d135d.firebaseio.com/products.json';
    //adding /products adds a folder into the database
    //for firebase, you need to add .json
    return http
        .post(
      url,
      body: json.encode(
        {
          'title': product.title,
          'description': product.description,
          'image': product.imageUrl,
          'price': product.price,
          'isFavorite': product.isFavorite,
        },
      ),
    )
        .then((response) {
      print(response.body);
      //will not execute immediately, will execute when http.post is done
      final newProduct = Product(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        id: json.decode(response.body)['name'], //DateTime.now().toString(),
        //better way to generate the ID
        //json.decode(response.body) is a map
        //also if we want to reference this object in another place to delete it,
        //it is much better
      );
      _items.add(newProduct);
      notifyListeners(); //this method is from ChangeNotifier
      //return Future.value();, cannot return inside a nested anonymous function,
      //instead we return to whole thing from http.post
      //post calls then and then returns a future

      //.catchError is called on .then(), this catches error thrown by http.post or .then
      //since if http.post throws an error, .then() will be skipped, going straight to .catchError
    }).catchError((errorObject) {
      print(errorObject);
      throw errorObject;
      //throw takes an error object and will return a new error
    });
    //json = javascript object notation
    //body parameter takes data in a json format, we must convert it into json
    //json format is like maps in dart
    //post has a parameter
    //json. is from the dart:convert library
  }

  Future<void> fetchAndSetProducts() async {
    const url = 'https://shopapp-d135d.firebaseio.com/products.json';
    //fetching data
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      final List<Product> loadedProducts = [];
      //Dart would give us an error if we did Map<String, Map<etc>> so we do Map<String, dynamic>
      extractedData.forEach((key, value) {
        loadedProducts.add(
          Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            isFavorite: value['isFavorite'],
            imageUrl: value['image'],
          ),
        );
      });
      _items = loadedProducts;
      notifyListeners();
      //update the products in the app
    } catch (error) {
      throw error;
    }
  }

  //when using the async keyword, all the code in the function automatically gets
  //wrapped into a future

  //USING ALTERNATIVE SYNTAX (BETTER)

  Future<void> addProduct(Product product) async {
    const url = 'https://shopapp-d135d.firebaseio.com/products.json';
    //instead of return, we use await
    //telling dart that we should wait for this to finish,
    //tells dart that we should wrap all the code that comes after this
    //into a then block

    //store await's value in a variable
    try {
      //wrap around the code what might fail, such as code which might fail due to internet connection
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'image': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          },
        ),
      );
      //we can then get rid of the .then
      //.then((response) {

      final newProduct = Product(
        title: product.title,
        description: product.description,
        imageUrl: product.imageUrl,
        price: product.price,
        id: json.decode(response.body)['name'],
      );
      _items.add(newProduct);
      notifyListeners();
    } catch (errorObject) {
      //we can also get rid of .catchError
      //}).catchError((errorObject) {
      print(errorObject);
      throw errorObject;
      //});
    }
  }

  Future<void> updateProduct(String id, Product newProduct) async {
    final productIndex = _items.indexWhere((product) => product.id == id);
    //makes sure that the index is found
    if (productIndex >= 0) {
      final url = 'https://shopapp-d135d.firebaseio.com/products/$id.json';
      await http.patch(url,
          body: json.encode({
            'title': newProduct.title,
            'description': newProduct.description,
            'imageUrl': newProduct.imageUrl,
            'price': newProduct.title,
            //favorite is not updated
          })); //tells the database to merge old data with new data
      //body is the new json data
      _items[productIndex] = newProduct;
      notifyListeners();
    }
  }

  Future<void> deleteProduct(String id) async {
    //200 201 everything worked
    //300 redirected
    //400 something went wrong
    //500 something went wrong
    final url = 'https://shopapp-d135d.firebaseio.com/products/$id.json';
    final existingProductIndex =
        _items.indexWhere((product) => product.id == id);
    var existingProduct = _items[existingProductIndex];
    _items.removeAt(existingProductIndex);
    notifyListeners();
    //this will remove the item from the list but not from local memory
    //the item will live on in memory
    //for get and post, they throw an error, but delete doesn't

    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(existingProductIndex, existingProduct);
      //this will insert the product back just in case delete fails
      notifyListeners();
      throw HttpException('Could not delete product.');
    }
    existingProduct = null;
    //if the delete succeeds, then you can completely remove references to the deleted item
  }
}
