import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/auth.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/orders.dart';
import 'package:shopapp/providers/product.dart';
import 'package:shopapp/providers/products.dart';
import 'package:shopapp/screens/cart_screen.dart';
import 'package:shopapp/screens/edit_product.dart';
import 'package:shopapp/screens/orders_screen.dart';
import 'package:shopapp/screens/product_detail_screen.dart';
import 'package:shopapp/screens/products_overview_screen.dart';
import 'package:shopapp/screens/user_products_screen.dart';
import 'package:shopapp/screens/auth_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (ctx) => Auth()),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (context) => Products("", []),
            update: (context, auth, previousProducts) =>
                Products(auth.token!, previousProducts!.items),
          ),
          //   ChangeNotifierProvider(create: (ctx) => Products()),
          ChangeNotifierProvider(create: (ctx) => Cart()),
          ChangeNotifierProvider(create: (ctx) => Orders()),
        ],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
                  title: 'Shop App',
                  theme: ThemeData(
                      colorScheme:
                          ColorScheme.fromSwatch(primarySwatch: Colors.pink)
                              .copyWith(secondary: Colors.purple)),
                  home: auth.isAuth ? productsOverviewScreen() : AuthScreen(),
                  //productsOverviewScreen(),
                  routes: {
                    // '/': (ctx) => productsOverviewScreen(),
                    ProductDetailScreen.routeName: (ctx) =>
                        ProductDetailScreen(),
                    cartScreen.routeName: (ctx) => cartScreen(),
                    OrdersScreen.routeName: (ctx) => OrdersScreen(),
                    UserProductScreen.routeName: (ctx) => UserProductScreen(),
                    editProductScreen.routeName: (ctx) => editProductScreen(),
                  },
                )));
  }
}
