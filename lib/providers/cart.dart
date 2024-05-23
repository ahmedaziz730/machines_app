import 'package:flutter/foundation.dart';

class CartItem {
  final String name;
  final int quantity;
  final double price;

  CartItem({
    required this.name,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String name, double price, int quantity) {
    if (_items.containsKey(name)) {
      // change quantity...
      _items.update(
        name,
        (existingCartItem) => CartItem(
          name: existingCartItem.name,
          price: existingCartItem.price,
          quantity: existingCartItem.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        name,
        () => CartItem(
          name: name,
          price: price,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  // void removeItem(String productId) {
  //   _items.remove(productId);
  //   notifyListeners();
  // }

  // void removeSingleItem(String productId) {
  //   if (!_items.containsKey(productId)) {
  //     return;
  //   }
  //   if (_items[productId].quantity > 1) {
  //     _items.update(
  //         productId,
  //         (existingCartItem) => CartItem(
  //               id: existingCartItem.id,
  //               title: existingCartItem.title,
  //               price: existingCartItem.price,
  //               quantity: existingCartItem.quantity - 1,
  //             ));
  //   } else {
  //     _items.remove(productId);
  //   }
  //   notifyListeners();
  // }

  void clearAll() {
    _items = {};
    notifyListeners();
  }
}
