import 'package:flutter/widgets.dart';

class CartItem {
  final String id;
  final String title;
  final double price;
  final int quantity;
  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.quantity,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _item = {};
  Map<String, CartItem> get item {
    return {..._item};
  }

  int get itemLength {
    return _item.length;
  }

  double get totalAmount {
    var total = 0.0;
    _item.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, double price, String title) {
    if (_item.containsKey(productId)) {
      _item.update(
        productId,
        (exixtingItem) => CartItem(
            id: exixtingItem.id,
            title: exixtingItem.title,
            price: exixtingItem.price,
            quantity: exixtingItem.quantity + 1),
      );
    } else {
      _item.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          title: title,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_item.containsKey(productId)) {
      return;
    }
    if (_item[productId]!.quantity > 1) {
      _item.update(
          productId,
          (existingCarItem) => CartItem(
              id: existingCarItem.id,
              title: existingCarItem.title,
              price: existingCarItem.price,
              quantity: existingCarItem.quantity - 1));
    } else {
      _item.remove(productId);
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _item.remove(productId);
    notifyListeners();
  }

  void clear() {
    _item = {};
    notifyListeners();
  }
}
