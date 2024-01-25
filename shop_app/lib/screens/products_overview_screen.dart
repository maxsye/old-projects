import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../providers/cart.dart';
import '../widgets/product_item.dart';
import '../widgets/badge.dart';
import '../screens/cart_screen.dart';
import '../widgets/app_drawer.dart';
import '../providers/products.dart';

enum FilterOptions {
  //so that we as developers can work with a label
  Favorites,
  All,
}

class ProductsOverviewScreen extends StatefulWidget {
  @override
  _ProductsOverviewScreenState createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;

  var _firstTime = true;

  var _isLoading = false;

  @override
  void initState() {
    //Provider.of<Products>(context).fetchAndSetProducts(); //since this uses context, this won't work
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // }); //could use this
    super.initState();
  }

  @override
  void didChangeDependencies() {
    //use didChangeDependencies with a boolean to get around the context not working in initState
    //cannot use async and await because async method always returns future, but this method returns void
    if (_firstTime) {
      setState(() {
        _isLoading = true;
        Provider.of<Products>(context).fetchAndSetProducts().then((_) {
          _isLoading = false;
        });
      });
    }
    _firstTime = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          PopupMenuButton(
            //the selected value is te value created in the PopupMenuItem value
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.Favorites, //value is here
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.All,
              ),
            ],
          ),
          Consumer<Cart>(
            builder: (context, cartObject, childThatDoesNotChange) => Badge(
              child: childThatDoesNotChange,
              value: cartObject.itemCount.toString(),
            ),
            child: IconButton(
              icon: Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final loadedProducts =
        showFavs ? productsData.favoriteItems : productsData.items;
    //sets up a direct communication channel with a provider
    //the class between the two angled brackets should be the provider class
    //uses the main.dart file's provider named Products
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        //there is a option to favorite an item and this class must update if it is selected
        value: loadedProducts[index],
        child: ProductItem(
            // loadedProducts[index].id,
            // loadedProducts[index].title,
            // loadedProducts[index].imageUrl,
            ),
      ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      //certain amount of columns, in this case 2 columns in the grid
      //items are taller than they are wide, 3 height for 2 length
      //10 pixels between
    );
  }
}
