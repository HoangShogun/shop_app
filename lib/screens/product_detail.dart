import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';

class ProductDetailScreen extends StatelessWidget {
  static String route = '/product-detail';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)?.settings.arguments as String;
    // final loadProduct = Provider.of<ProductsProvider>(context, listen: false)
    //     .findById(productId);
    return Consumer<ProductsProvider>(
        builder: (context, value, child) => Scaffold(
              appBar: AppBar(
                title: Text(value.findById(productId).title),
              ),
            ));
  }
}
