import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'login.dart';

class AdminHomePage extends StatelessWidget {
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  auth.signOut();
                  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
                }
            );
          },
        ),
        title: Text('Admin'),
        actions: [
          IconButton(
              icon: Icon(
                Icons.settings,
                color: Colors.white
              ),
              onPressed: () {})
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(30),
            child: Text(
                'Management',
              style: TextStyle(
                fontSize: 30.0,
              ),
            ),
          ),
          Column(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
                height: 70,
                alignment: Alignment.center,
                color: Colors.blue,
                child: Text(
                  'Inventory Management',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
                height: 70,
                alignment: Alignment.center,
                color: Colors.blue,
                child: Text(
                  'Price Management',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20, bottom: 20, left: 30, right: 30),
                height: 70,
                alignment: Alignment.center,
                color: Colors.blue,
                child: Text(
                  'Item Management',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}