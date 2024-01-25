import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        body: FutureBuilder(
          future:
              Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
          builder: (context, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error == null) {
                return Consumer<Orders>(
                    builder: (context, orderData, child) => ListView.builder(
                        itemBuilder: (context, index) =>
                            OrderItem(orderData.orders[index]),
                        itemCount: orderData.orders.length));
              }
              return Center(
                child: Text('An error occurred'),
              );
            }
          },
        ));
  }
}
