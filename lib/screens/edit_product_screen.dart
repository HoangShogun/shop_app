import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const route = '/edit-product-screen';
  const EditProductScreen({Key? key}) : super(key: key);

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _imageUrlFocusNode = FocusNode();
  final _imageUrlController = TextEditingController();
  var _isInit = true;
  final _form = GlobalKey<FormState>();
  bool _isLoading = false;
  var _editedProduct =
      Product(id: '', title: '', description: '', price: 0.0, imageUrl: '');
  var _initData = {'title': '', 'description': '', 'price': '', 'imageUrl': ''};

  Future<void> _saveForm() async {
    _form.currentState?.validate();
    _form.currentState?.save();
    setState(() {
      _isLoading = true;
    });

    if (_editedProduct.id != '') {
      await Provider.of<ProductsProvider>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
    } else {
      try {
        await Provider.of<ProductsProvider>(context, listen: false)
            .addProduct(_editedProduct);
      } catch (e) {
        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Something went wrong!'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Okey'))
              ],
            );
          },
        );
        // } finally {
        //   _isLoading = false;
        //   Navigator.of(context).pop();
      }
    }
    setState(() {
      _isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  void initState() {
    _imageUrlFocusNode.addListener(() {
      _updateImageUrl();
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productId = ModalRoute.of(context)?.settings.arguments as String;
      if (productId != 'add product') {
        _editedProduct = Provider.of<ProductsProvider>(context, listen: false)
            .findById(productId);
        _initData = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': ''
        };
        _imageUrlController.text = _editedProduct.imageUrl;
      }
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _imageUrlFocusNode.removeListener(() {
      _updateImageUrl();
    });
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
              iconSize: 30,
              onPressed: () => _saveForm(),
              icon: const Icon(Icons.save))
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                  key: _form,
                  child: ListView(
                    children: [
                      TextFormField(
                        initialValue: _initData['title'],
                        decoration: const InputDecoration(labelText: 'Title'),
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context).requestFocus(_priceFocusNode);
                        },
                        onSaved: (newValue) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              title: newValue.toString(),
                              description: _editedProduct.description,
                              price: _editedProduct.price,
                              imageUrl: _editedProduct.imageUrl);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Pls provide a value';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _initData['price'],
                        decoration: const InputDecoration(labelText: 'Price'),
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.number,
                        focusNode: _priceFocusNode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_descriptionFocusNode);
                        },
                        onSaved: (newValue) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: _editedProduct.description,
                              price: double.parse(newValue.toString()),
                              imageUrl: _editedProduct.imageUrl);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Pls provide a value';
                          }
                          if (double.tryParse(value) == null) {
                            return 'pls provide a valid number';
                          }
                          if (double.parse(value) <= 0) {
                            return 'pls provide a valid greatter than zero';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        initialValue: _initData['description'],
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        maxLines: 3,
                        keyboardType: TextInputType.multiline,
                        focusNode: _descriptionFocusNode,
                        onFieldSubmitted: (value) {
                          FocusScope.of(context)
                              .requestFocus(_imageUrlFocusNode);
                        },
                        onSaved: (newValue) {
                          _editedProduct = Product(
                              id: _editedProduct.id,
                              title: _editedProduct.title,
                              description: newValue.toString(),
                              price: _editedProduct.price,
                              imageUrl: _editedProduct.imageUrl);
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Pls provide a value';
                          }
                          return null;
                        },
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            margin: const EdgeInsets.only(top: 8, right: 10),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.grey)),
                            child: _imageUrlController.text.isEmpty
                                ? const Text('Enter a URL')
                                : FittedBox(
                                    fit: BoxFit.cover,
                                    child:
                                        Image.network(_imageUrlController.text),
                                  ),
                          ),
                          Expanded(
                              child: TextFormField(
                            decoration:
                                const InputDecoration(labelText: 'Image URL'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlController,
                            focusNode: _imageUrlFocusNode,
                            onFieldSubmitted: (value) => _saveForm(),
                            onSaved: (newValue) {
                              _editedProduct = Product(
                                  id: _editedProduct.id,
                                  title: _editedProduct.title,
                                  description: _editedProduct.description,
                                  price: _editedProduct.price,
                                  imageUrl: newValue.toString());
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Pls provide a vlaue';
                              }
                              // if (!value.startsWith('http:') &&
                              //     !value.startsWith('https:')) {
                              //   return 'Pls provide a valid url';
                              // }
                              // if (!value.endsWith('png') && !value.endsWith('jpg')) {
                              //   return 'Pls provide a valid image';
                              // }
                              return null;
                            },
                          ))
                        ],
                      )
                    ],
                  )),
            ),
    );
  }
}
