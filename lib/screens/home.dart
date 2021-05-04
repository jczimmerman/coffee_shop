import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class HomePage extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
            child:

          Text('Welcome To',
              style: TextStyle(color: Colors.blueAccent,
                  fontSize: 30),
          ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child:
          Text('True Bean Cafe',
          style: TextStyle(color: Colors.blueAccent,
          fontSize: 50)
          ),
          ),


          Padding(

              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Image.asset('assets/images/bean_heart.png'),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
            child: Text('Where We Deliver The Best Coffee Around',
                style: TextStyle(color: Colors.brown,
                  fontSize: 30,
                ),
                textAlign: TextAlign.center

            ),
          ),
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