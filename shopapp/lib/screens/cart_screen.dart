import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:shopapp/cart.dart';

class cartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const cartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Cart'),
        ),
        body: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Total'),
                    Spacer(),
                    Chip(
                      label: Text('\$${cart.totalAmount}'),
                    ),
                    TextButton(onPressed: null, child: Text('Order Now'))
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            Expanded(child: ListView.builder(itemCount:
            cart.items.length,
            ,itemBuilder: (ctx,i){
              
            }
            
            ),)
            
          ],
        ));
  }
}
