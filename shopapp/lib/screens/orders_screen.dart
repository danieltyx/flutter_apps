import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/providers/cart.dart';
import 'package:shopapp/providers/orders.dart' as ord;
import 'package:shopapp/widgets/app_drawer.dart';
import 'package:shopapp/widgets/order_item.dart' as oi;
import 'package:shopapp/widgets/cart_item.dart' as ci;

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<ord.Orders>(context).orders;

    return Scaffold(
        appBar: AppBar(title: Text('Orders')),
        drawer: AppDrawer(),
        body: ListView.builder(
            itemCount: orders.length,
            itemBuilder: ((context, index) => oi.OrderItem(orders[index]))));
  }
}
