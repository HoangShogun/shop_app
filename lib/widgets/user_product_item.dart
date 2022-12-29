import 'package:flutter/material.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;

  const UserProductItem(
      {super.key, required this.title, required this.imageUrl});

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
              IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
              IconButton(
                  onPressed: () {},
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
