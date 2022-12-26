import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/badge.dart';
import '../widgets/product_grid.dart';

enum FilterOption {
  favorite,
  all,
}

class ProductsScreen extends StatefulWidget {
  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  var _showOnlyFavorite = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Consumer<Cart>(
            builder: (_, cartData, child) => Badge(
              child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.route);
                },
              ),
              value: cartData.itemCount().toString(),
            ),
          ),
          PopupMenuButton(
            onSelected: (FilterOption selectedOption) {
              setState(() {
                if (selectedOption == FilterOption.favorite) {
                  _showOnlyFavorite = true;
                } else {
                  _showOnlyFavorite = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: FilterOption.favorite,
                child: Text('Show Favorite'),
              ),
              PopupMenuItem(
                value: FilterOption.all,
                child: Text('Show all'),
              ),
            ],
          ),
        ],
        // ignore: prefer_const_constructors
        title: Text('Products'),
      ),
      body: ProductGrid(
        showFavorite: _showOnlyFavorite,
      ),
    );
  }
}
