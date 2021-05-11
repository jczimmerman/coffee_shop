import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/screens/menus/coffee_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Cart extends StatelessWidget {
  final CoffeeItem coffeeItem;

  Cart({Key key, this.coffeeItem}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          Container(
              child: IconButton(
                  icon: Icon(Icons.shopping_cart_outlined),
                  onPressed: () {}


              )
          ),
        ],
      ),


    );
  }
}