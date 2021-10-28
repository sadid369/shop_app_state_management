import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_state_management/provider/orders.dart' show Orders;
import 'package:shop_app_state_management/widgets/app_drawer.dart';
import 'package:shop_app_state_management/widgets/order_items.dart';

class OrderScreen extends StatefulWidget {
  static const routeName = '/order-screen';

  @override
  _OrderScreenState createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future? _orderFuture;

  Future _obtainOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchAndSetOrders();
  }

  @override
  void initState() {
    _orderFuture = _obtainOrdersFuture();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Building orders');
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          title: Text('Your Order'),
        ),
        body: FutureBuilder(
          future: _orderFuture,
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              if (dataSnapshot.error != null) {
                return Center(
                  child: Text('An Error Occurred'),
                );
              } else {
                return Consumer<Orders>(
                    builder: (ctx, orderData, child) => ListView.builder(
                          itemCount: orderData.order.length,
                          itemBuilder: (cxt, i) => OrderItem(
                            order: orderData.order[i],
                          ),
                        ));
              }
            }
          },
        ));
  }
}
