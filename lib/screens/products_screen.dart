import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/drawer.dart';
import '../widgets/product_grid.dart';

enum FilterOption {
  favorite,
  all,
}

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  var _isInit = true;
  var _showOnlyFavorite = false;
  var _isLoading = false;
  @override
  void didChangeDependencies() async {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<ProductsProvider>(context).fetchAndSetProduct().then((value) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: [
          Consumer<Cart>(
            builder: (_, cartData, child) => Badge(
              value: cartData.itemCount().toString(),
              child: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.pushNamed(context, CartScreen.route);
                },
              ),
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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductGrid(
              showFavorite: _showOnlyFavorite,
            ),
    );
  }
}
