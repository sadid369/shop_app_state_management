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
  final String? token;
  final String? userId;
  Orders(this.token, this._orders, this.userId);
  List<OrderItem> _orders = [];
  List<OrderItem> get order {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url =
        'https://shop-app22-default-rtdb.asia-southeast1.firebasedatabase.app/orders/$userId.json?auth=$token';
    final response = await http.get(Uri.parse(url));
    print(json.decode(response.body));
    final List<OrderItem> loadedData = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData == null) {
      return;
    }
    extractedData.forEach((orderId, orderData) {
      loadedData.add(OrderItem(
          id: orderId,
          amount: orderData['amount'],
          dateTime: DateTime.parse(orderData['dateTime']),
          products: (orderData['products'] as List<dynamic>)
              .map((item) => CartItem(
                  id: item['id'],
                  title: item['title'],
                  price: item['price'],
                  quantity: item['quantity']))
              .toList()));
    });
    _orders = loadedData.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrders(List<CartItem> cartProduct, double total) async {
    final url =
        'https://shop-app22-default-rtdb.asia-southeast1.firebasedatabase.app/orders/$userId.json?auth=$token';
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
