import 'package:coffee_shop/screens/cart/checkout.dart';
import 'package:coffee_shop/screens/cart/shop_items.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'screens/login.dart';
final firestoreInstance = FirebaseFirestore.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      title: 'The Caffeine Bean',
      home: LoginPage(),
      routes: {
        '/items': (BuildContext context) => ShopItems(),
        '/checkout': (BuildContext context) => Checkout()
      },
    );
  }
}

