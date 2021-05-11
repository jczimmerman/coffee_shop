import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/screens/menus/coffee_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop/screens/home.dart';
import 'package:coffee_shop/screens/menus/coffee_menu.dart';

class Cart extends StatefulWidget {


  Cart({this.cartItems});
  final List<List> cartItems;


  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {

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
      body: new ListView.builder(
        itemCount: widget.cartItems.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Card(
              child: ListTile(
                leading: Image.asset('assets/images/bean_heart.jpg'),
                title: Text(widget.cartItems[index])

              )
            )
          );
        }
      )





    );
  }
}