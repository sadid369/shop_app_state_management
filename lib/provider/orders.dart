import 'package:flutter/material.dart';
import 'package:shop_app_state_management/provider/cart.dart';
import 'package:shop_app_state_management/provider/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> addOrders(List<CartItem> cartProduct, double total) async {
    final url =
        'https://shopapp2-38b15-default-rtdb.asia-southeast1.firebasedatabase.app/orders.json';
    final timeStamp = DateTime.now();
    final response = await http.post(Uri.parse(url),
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProduct
              .map((cp) => {
                    'title': cp.title,
                    'price': cp.price,
                    'quantity': cp.quantity,
                    'id': cp.id,
                  })
              .toList(),
        }));

    _orders.insert(
      0,
      OrderItem(
        amount: total,
        id: json.decode(response.body)['name'],
        dateTime: timeStamp,
        products: cartProduct,
      ),
    );
    notifyListeners();
  }
}
