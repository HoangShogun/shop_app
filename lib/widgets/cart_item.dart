import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productId;
  final double amount;
  final String title;
  final int quantity;

  const CartItem(
      {super.key,
      required this.productId,
      required this.id,
      required this.amount,
      required this.title,
      required this.quantity});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      onDismissed: (direction) =>
          Provider.of<Cart>(context, listen: false).removeItem(productId),
      direction: DismissDirection.endToStart,
      background: Container(
        // margin: EdgeInsets.only(),
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(
          Icons.delete,
          size: 40,
          color: Colors.white,
        ),
      ),
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
            padding: const EdgeInsets.all(8),
            child: ListTile(
              leading: CircleAvatar(
                child: FittedBox(child: Text('\$$amount')),
              ),
              title: Text(title),
              subtitle: Text('${amount * quantity} \$'),
              trailing: Text(
                '${quantity}x',
                style: const TextStyle(fontSize: 18),
              ),
            )),
      ),
    );
  }
}
