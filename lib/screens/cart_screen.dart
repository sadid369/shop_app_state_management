import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_state_management/provider/cart.dart' show Cart;
import 'package:shop_app_state_management/provider/orders.dart';
import 'package:shop_app_state_management/screens/order_screen.dart';
import 'package:shop_app_state_management/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const nameRoute = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount}',
                      style: TextStyle(
                          color:
                              Theme.of(context).primaryTextTheme.title!.color),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  OrderButton(cart: cart)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.item.length,
              itemBuilder: (ctx, i) => CartItem(
                  productId: cart.item.keys.toList()[i],
                  id: cart.item.values.toList()[i].id,
                  price: cart.item.values.toList()[i].price,
                  quantity: cart.item.values.toList()[i].quantity,
                  title: cart.item.values.toList()[i].title),
            ),
          ),
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
        disabledTextColor: Colors.grey,
        textColor: Theme.of(context).primaryColor,
        onPressed: (widget.cart.totalAmount <= 0)
            ? null
            : () async {
                setState(() {
                  _isLoading = true;
                });
                await Provider.of<Orders>(context, listen: false).addOrders(
                    widget.cart.item.values.toList(), widget.cart.totalAmount);
                setState(() {
                  _isLoading = false;
                });
                widget.cart.clear();
              },
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Text(
                'Order Now',
              ));
  }
}
