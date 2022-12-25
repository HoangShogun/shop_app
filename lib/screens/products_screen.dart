import 'package:flutter/material.dart';
import '../widgets/product_grid.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text('Products'),
      ),
      body: ProductGrid(),
    );
  }
}
