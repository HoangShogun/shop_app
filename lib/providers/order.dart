import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import '../providers/cart.dart' as ci;

class OrderItem {
  final String id;
  final double amount;
  final DateTime date;
  final List<ci.CartItem> products;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.date,
      required this.products});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<ci.CartItem> cartProducts, double total) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: total,
            date: DateTime.now(),
            products: cartProducts));
    notifyListeners();
  }
}
