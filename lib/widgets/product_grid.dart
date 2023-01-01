import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

import 'product_item.dart';

class ProductGrid extends StatelessWidget {
  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<ProductsProvider>(context, listen: false)
        .fetchAndSetProduct();
  }

  final bool showFavorite;
  ProductGrid({required this.showFavorite});
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductsProvider>(context);
    final product = showFavorite ? productData.itemFav : productData.items;
    return RefreshIndicator(
      onRefresh: () => _refreshProducts(context),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          padding: const EdgeInsets.all(10),
          itemCount: product.length,
          itemBuilder: (context, index) => ChangeNotifierProvider.value(
            value: product[index],
            child: ProductItem(),
          ),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
        ),
      ),
    );
  }
}
