import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/cart_item.dart' as ci;

import '../providers/cart.dart';

class CartScreen extends StatelessWidget {
  static final route = '/cart-screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: Column(
        children: [
          Card(
            elevation: 10,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(children: [
                const Text(
                  'Total',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Chip(
                  label: Text(
                    '\$ ${cart.totalAmount().toString()}',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  backgroundColor: Colors.purple,
                ),
                TextButton(
                    onPressed: () => print('\$${cart.totalAmount}'),
                    child: const Text('Order Now'))
              ]),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) => ci.CartItem(
                  id: cart.items.values.toList()[index].id,
                  amount: cart.items.values.toList()[index].price,
                  title: cart.items.values.toList()[index].title,
                  quantity: cart.items.values.toList()[index].quantity),
            ),
          )
        ],
      ),
    );
  }
}
