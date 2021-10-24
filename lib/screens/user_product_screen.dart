import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_state_management/provider/products.dart';
import 'package:shop_app_state_management/screens/edit_product_screen.dart';
import 'package:shop_app_state_management/widgets/app_drawer.dart';
import 'package:shop_app_state_management/widgets/user_product.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = 'user-product-screen';
  Future<void> refreshProduct(BuildContext context) async {
    await Provider.of<Products>(context).fatchAndSetData();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await refreshProduct(context);
        },
        child: ListView.builder(
          itemBuilder: (ctx, i) => Column(
            children: [
              UserProduct(
                id: productData.items[i].id,
                title: productData.items[i].title,
                imageUrl: productData.items[i].imageUrl,
              ),
              Divider(),
            ],
          ),
          itemCount: productData.items.length,
        ),
      ),
    );
  }
}
