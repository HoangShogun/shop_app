import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductsProvider with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get itemFav {
    return _items.where((element) => element.isFavorite == true).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProduct() async {
    final url = Uri.parse(
        'https://flutter-test-38f33-default-rtdb.firebaseio.com/product.json');
    try {
      final respone = await http.get(url);
      final extractData = json.decode(respone.body) as Map<String, dynamic>;
      final List<Product> loadingProduct = [];
      extractData.forEach(
        (productId, productData) {
          loadingProduct.add(Product(
              id: productId,
              title: productData['title'],
              description: productData['description'],
              price: double.parse(productData['price'].toString()),
              imageUrl: productData['imageUrl']));
        },
      );
      _items = loadingProduct;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://flutter-test-38f33-default-rtdb.firebaseio.com/product.json');
    try {
      final respone = await http.post(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          }));

      // print(respone.body);
      final newProduct = Product(
          id: json.decode(respone.body)['name'],
          title: product.title,
          description: product.description,
          price: product.price,
          imageUrl: product.imageUrl);
      _items.add(newProduct);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateProduct(String productId, Product product) async {
    var index = _items.indexWhere((element) => element.id == productId);
    if (index >= 0) {
      final url = Uri.parse(
          'https://flutter-test-38f33-default-rtdb.firebaseio.com/product/$productId.json');
      await http.patch(url,
          body: json.encode({
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
          }));
      _items[index] = product;
      notifyListeners();
    } else {
      print('...');
    }
  }

  Future<void> deleteProduct(String productId) async {
    final url = Uri.parse(
        'https://flutter-test-38f33-default-rtdb.firebaseio.com/product/$productId.json');
    await http.delete(url);
    _items.removeAt(_items.indexWhere(
      (element) => element.id == productId,
    ));
    //c???n th??m exception
    notifyListeners();
  }
}
