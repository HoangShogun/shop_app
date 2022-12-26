import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CartItem extends StatelessWidget {
  final String id;
  final double amount;
  final String title;
  final int quantity;

  const CartItem(
      {super.key,
      required this.id,
      required this.amount,
      required this.title,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
          padding: EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: FittedBox(child: Text('\$$amount')),
            ),
            title: Text(title),
            subtitle: Text((amount * quantity).toString() + ' \$'),
            trailing: Text(quantity.toString() + 'x'),
          )),
    );
  }
}
