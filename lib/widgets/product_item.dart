import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  // final String id;
  // final String title;
  // final String imageUrl;

  // ignore: use_key_in_widget_constructors
  // const ProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return Consumer<Product>(
      builder: (context, value, child) => GestureDetector(
        onTap: () {
          Navigator.of(context)
              .pushNamed(ProductDetailScreen.route, arguments: value.id);
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: GridTile(
            footer: GridTileBar(
              backgroundColor: Colors.black54,
              leading: IconButton(
                icon: const Icon(Icons.favorite),
                color: value.isFavorite ? Colors.red : Colors.white,
                onPressed: () {
                  value.toggleFavorite();
                },
              ),
              title: Text(
                value.title,
                textAlign: TextAlign.center,
              ),
              trailing: IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
            ),
            child: Image.network(
              value.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
