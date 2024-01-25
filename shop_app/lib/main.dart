import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; //importing Provider package

import './screens/orders_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './screens/cart_screen.dart';
import './providers/orders.dart';
import './screens/user_products_screen.dart';
import './screens/edit_product_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //allows us to register a class to which widgets can listen to
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => CartScreen(),
          OrdersScreen.routeName: (context) => OrdersScreen(),
          UserProductsScreen.routeName: (context) => UserProductsScreen(),
          EditProductScreen.routeName: (context) => EditProductScreen(),
        },
      ),
    );
  }
}

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('MyShop'),
//       ),
//       body: Center(
//         child: Text('Shop'),
//       ),
//     );
//   }
// }
