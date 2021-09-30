import 'package:flutter/material.dart';
import 'package:shop_app_state_management/provider/products.dart';
import 'package:shop_app_state_management/screens/edit_product_screen.dart';
import 'package:provider/provider.dart';

class UserProduct extends StatelessWidget {
  final String? id;
  final String title;
  final String imageUrl;
  const UserProduct({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      title: Text(title),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              icon: Icon(Icons.edit),
            ),
            IconButton(
                onPressed: () {
                  Provider.of<Products>(context, listen: false).deleteProduct(id);
                },
                icon: Icon(
                  Icons.delete,
                  color: Theme.of(context).errorColor,
                )),
          ],
        ),
      ),
    );
  }
}
