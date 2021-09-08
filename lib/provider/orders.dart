import 'package:flutter/material.dart';
import 'package:shop_app_state_management/provider/cart.dart';
import 'package:shop_app_state_management/provider/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final DateTime dateTime;
  final List<CartItem> products;
  OrderItem({
    required this.id,
    required this.amount,
    required this.dateTime,
    required this.products,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get order {
    return [..._orders];
  }

  void addOrders(List<CartItem> cartProduct, double total) {
    _orders.insert(
      0,
      OrderItem(
        amount: total,
        id: DateTime.now().toString(),
        dateTime: DateTime.now(),
        products: cartProduct,
      ),
    );
  }
}
