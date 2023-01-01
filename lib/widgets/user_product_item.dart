import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products_provider.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem(
      {super.key,
      required this.id,
      required this.title,
      required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(title),
          leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
          trailing: SizedBox(
            width: 100,
            child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamed(EditProductScreen.route, arguments: id);
                  },
                  icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () async {
                    await Provider.of<ProductsProvider>(context, listen: false)
                        .deleteProduct(id);
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ]),
          ),
        ),
        const Divider(),
      ],
    );
  }
}
