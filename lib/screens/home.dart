import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'menus/coffee_menu.dart';
import 'menus/tea_menu.dart';
final firestoreInstance = FirebaseFirestore.instance;

class HomePage extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
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
            margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),
            child: new ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                Container(
                  margin: EdgeInsets.all(10),
                  child: Center(

                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement((MaterialPageRoute(builder: (context) => CoffeeMenu())));
                        },
                        child: Text('Coffee')
                    ),
                  ),
                  height: 50,
                  color: Colors.amber,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Center(
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement((MaterialPageRoute(builder: (context) => TeaMenu())));
                        },
                        child: Text('Coffee')
                    ),
                  ),
                  height: 50,
                  color: Colors.grey,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Center(
                    child: Text('Pastries'),
                  ),
                  height: 50,
                  color: Colors.amber,
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Center(
                    child: Text('Desserts'),
                  ),
                  height: 50,
                  color: Colors.grey,
                ),
                TextButton(
                  onPressed: (){
                    firestoreInstance.collection("coffee_menu").get().then((querySnapshot) {
                      querySnapshot.docs.forEach((result) {
                        print(result.data()['name']);
                      });
                    });
                  },
                  child: Text(
                      "Get the coffee Menu"
                  ),
                ),
              ],
            ),

          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              child: DrawerHeader(
                child: Text('User Actions'),
                decoration: BoxDecoration(
                  color: Colors.blue
                ),
              ),
              margin: EdgeInsets.all(0),
              padding: EdgeInsets.all(0),
            ),
            ListTile(
              title: Text('Settings'),
              onTap: () {
                auth.signOut();
                //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            ListTile(
              title: Text('Account'),
              onTap: () {
                auth.signOut();
                //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            ListTile(
              title: Text('Cart'),
              onTap: () {
                auth.signOut();
                //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            ListTile(
              title: Text('Payment Methods'),
              onTap: () {
                auth.signOut();
                //Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
            ListTile(
              title: Text('Logout'),
              onTap: () {
                auth.signOut();
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
              },
            ),
          ],
        )
      ),
    );
  }
}