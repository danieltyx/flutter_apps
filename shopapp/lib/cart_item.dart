import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(child),
        ));
  }
}
