import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../screens/edit_product_screen.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products';

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);

    Future<void> _refreshProducts() async{
    await Provider.of<Products>(context).fetchAndSetProducts();
  }
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          ),
        ],
      ),
      //adding a pull to refresh function
      body: RefreshIndicator(
        onRefresh: _refreshProducts,
              child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
              itemBuilder: (context, index) => Column(
                    children: <Widget>[
                      UserProductItem(
                        productsData.items[index].id,
                        productsData.items[index].title,
                        productsData.items[index].imageUrl,
                      ),
                      Divider(),
                    ],
                  ),
              itemCount: productsData.items.length),
        ),
      ),
    );
  }
}
