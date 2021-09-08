import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_state_management/provider/orders.dart' show Orders;
import 'package:shop_app_state_management/widgets/app_drawer.dart';
import 'package:shop_app_state_management/widgets/order_items.dart';

class OrderScreen extends StatelessWidget {
  static const routeName = '/order-screen';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Your Order'),
      ),
      body: ListView.builder(
        itemCount: orderData.order.length,
        itemBuilder: (cxt, i) => OrderItem(
          order: orderData.order[i],
        ),
      ),
    );
  }
}
