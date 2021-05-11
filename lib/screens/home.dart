import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'menus/coffee_menu.dart';
import 'menus/tea_menu.dart';
import 'cart/cart.dart';
import 'menus/pastry_menu.dart';
import 'menus/dessert_menu.dart';
final firestoreInstance = FirebaseFirestore.instance;

class HomePage extends StatelessWidget {
  HomePage({Key key, this.email}) : super(key: key);
  final String email;

  final auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                auth.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            );
          },
        ),
        actions: [
          Container(
          child: IconButton(
            icon: Icon(Icons.shopping_cart_outlined),
              onPressed: () {
                Navigator.push( context,
                  MaterialPageRoute(
                    builder: (context) => Cart(email: email,),
                  ),
                );
              }
          )
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              "Today's Favorites",
              style: TextStyle(
                fontSize: 20.0,

              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            height: 200,
            child: new ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/black_coffee.jpg'),
                      fit: BoxFit.cover
                    )
                  ),
                  child: Stack(
                    children: [
                      Text(
                          'Black Coffee',
                        style: TextStyle(
                          fontSize: 25.0,
                          foreground: Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 3
                            ..color = Colors.black
                        )
                      ),
                      Text(
                        'Black Coffee',
                        style: TextStyle(
                          fontSize: 25.0,
                          color: Colors.white
                        ),
                      )
                    ],
                  ),
                  width: 200,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/green_tea.jpg'),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Stack(
                    children: [
                      Text(
                          'Green Tea',
                          style: TextStyle(
                              fontSize: 25.0,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = Colors.black
                          )
                      ),
                      Text(
                        'Green Tea',
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white
                        ),
                      )
                    ],
                  ),
                  width: 200,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/frappe.jpg'),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Stack(
                    children: [
                      Text(
                          'Frappe',
                          style: TextStyle(
                              fontSize: 25.0,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = Colors.black
                          )
                      ),
                      Text(
                        'Frappe',
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white
                        ),
                      )
                    ],
                  ),
                  width: 200,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/biscuit.jpg'),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Stack(
                    children: [
                      Text(
                          'Biscuit',
                          style: TextStyle(
                              fontSize: 25.0,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = Colors.black
                          )
                      ),
                      Text(
                        'Biscuit',
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white
                        ),
                      )
                    ],
                  ),
                  width: 200,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/crumpet.jpg'),
                          fit: BoxFit.cover
                      )
                  ),
                  child: Stack(
                    children: [
                      Text(
                          'Crumpet',
                          style: TextStyle(
                              fontSize: 25.0,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 3
                                ..color = Colors.black
                          )
                      ),
                      Text(
                        'Crumpet',
                        style: TextStyle(
                            fontSize: 25.0,
                            color: Colors.white
                        ),
                      )
                    ],
                  ),
                  width: 200,
                )
              ],
            ),
          ),
          Center(
            child:

            Text(
                'Menu',
              style: TextStyle(
                fontSize: 20.0
              ),

            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            child: new ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.blue
                  ),
                  margin: EdgeInsets.all(10),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push((MaterialPageRoute(builder: (context) => CoffeeMenu(email: email))));
                      },
                      child: Text(
                        'Coffee',
                        style: TextStyle(
                          fontSize: 23,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.blue
                  ),
                  margin: EdgeInsets.all(10),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push((MaterialPageRoute(builder: (context) => TeaMenu(email: email))));
                      },
                      child: Text(
                        'Tea',
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.blue
                  ),
                  margin: EdgeInsets.all(10),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push((MaterialPageRoute(builder: (context) => PastryMenu(email: email))));
                      },
                      child: Text(
                        'Pastries',
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.blue
                  ),
                  margin: EdgeInsets.all(10),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push((MaterialPageRoute(builder: (context) => DessertMenu(email: email))));
                      },
                      child: Text(
                        'Dessert',
                        style: TextStyle(
                            fontSize: 23,
                            color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

          )
        ],
      ),
    );
  }
}