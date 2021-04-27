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
      body: Container(
        child: Text('Home'),
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