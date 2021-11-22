import 'package:flutter/material.dart';
import 'package:shop_app_state_management/provider/auth.dart';
import 'package:shop_app_state_management/provider/cart.dart';
import 'package:shop_app_state_management/provider/orders.dart';
import 'package:shop_app_state_management/provider/product.dart';
import 'package:shop_app_state_management/provider/products.dart';
import 'package:shop_app_state_management/screens/auth_screen.dart';
import 'package:shop_app_state_management/screens/cart_screen.dart';
import 'package:shop_app_state_management/screens/edit_product_screen.dart';
import 'package:shop_app_state_management/screens/order_screen.dart';
import 'package:shop_app_state_management/screens/product_detail_screen.dart';
import 'package:shop_app_state_management/screens/products_overview_screen.dart';
import 'package:provider/provider.dart';
import 'package:shop_app_state_management/screens/user_product_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (cxt) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MyShop',
        theme: ThemeData(
          fontFamily: 'Lato',
          accentColor: Colors.deepOrange,
          primarySwatch: Colors.purple,
        ),
        home: AuthScreen(),
        routes: {
          // '/': (ctx) => ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.nameRoute: (ctx) => CartScreen(),
          OrderScreen.routeName: (ctx) => OrderScreen(),
          UserProductScreen.routeName: (ctx) => UserProductScreen(),
          EditProductScreen.routeName: (ctx) => EditProductScreen(),
        },
      ),
    );
  }
}
