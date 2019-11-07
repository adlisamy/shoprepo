import 'package:flutter/foundation.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;
  CartItem(
      {@required this.id,
      @required this.title,
      @required this.quantity,
      @required this.price});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _cartItems = {};

  Map<String, CartItem> get cartItems {
    return {..._cartItems};
  }

  int get countItems {
    return _cartItems.length;
  }

  double get totalAmount {
    var total = 0.0;
    _cartItems.forEach((key, item) => total += item.price * item.quantity);
    return total;
  }

  void addItem(String id, String title, double price) {
    if (_cartItems.containsKey(id)) {
      _cartItems.update(
          id,
          (existingCartItem) => CartItem(
              id: existingCartItem.id,
              title: existingCartItem.title,
              price: existingCartItem.price,
              quantity: existingCartItem.quantity + 1));
    } else {
      _cartItems.putIfAbsent(
          id,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (!_cartItems.containsKey(id)) {
      return;
    }
    if (_cartItems[id].quantity > 1) {
      _cartItems.update(
        id,
        (existingCartItem) => CartItem(
          id: existingCartItem.id,
          price: existingCartItem.price,
          title: existingCartItem.title,
          quantity: existingCartItem.quantity - 1,
        ),
      );
    } else {
      _cartItems.remove(id);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _cartItems.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _cartItems = {};
    notifyListeners();
  }
}
