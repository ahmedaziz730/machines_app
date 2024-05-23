import 'package:flutter/foundation.dart';

import './cart.dart';

class OrderItem {
  final String name;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.name,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartProducts, double total, String na) {
    _orders.insert(
      0,
      OrderItem(
        name: na,
        amount: total,
        dateTime: DateTime.now(),
        products: cartProducts,
      ),
    );
    _orders.retainWhere(
      (element) => element.amount == total,
    );

    notifyListeners();
  }

  void clear() {
    _orders.clear();
    print(_orders);
    notifyListeners();
  }
}
