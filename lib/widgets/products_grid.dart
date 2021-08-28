import 'package:flutter/material.dart';
import 'package:shop_app_state_management/models/product.dart';
import 'package:shop_app_state_management/provider/products.dart';
import 'package:shop_app_state_management/widgets/product_item.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    final products = productData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (ctx, i) => ProductItem(
        id: products[i].id,
        title: products[i].title,
        imageUrl: products[i].imageUrl,
      ),
      itemCount: products.length,
    );
  }
}
