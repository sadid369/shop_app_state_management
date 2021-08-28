import 'package:flutter/material.dart';
import 'package:shop_app_state_management/models/product.dart';
import 'package:shop_app_state_management/provider/products.dart';
import 'package:shop_app_state_management/screens/product_detail_screen.dart';
import 'package:shop_app_state_management/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          fontFamily: 'Lato',
          accentColor: Colors.deepOrange,
          primarySwatch: Colors.purple,
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}
