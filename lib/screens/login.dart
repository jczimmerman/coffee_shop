import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

import 'admin_home.dart';
import 'home.dart';
import 'register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email, _password, _error;
  final auth = FirebaseAuth.instance;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Email...'
              ),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
            )
          ),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password...'
                ),
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
              )
          ),
          ElevatedButton(
              onPressed: () {
                firebaseSignIn(_email, _password);
              },
              child: Text('Sign in')
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement((MaterialPageRoute(builder: (context) => RegisterPage())));
              },
              child: Text('Sign up')
          ),
        ],
      ),
    );
  }

    Map<String, Object> checkUserType(String user) {
      DocumentReference ref = FirebaseFirestore.instance.collection('users').doc(user);
      Map<String, Object> userType;
      final userRole = ref.get().then(
        (docSnap) => userType = docSnap.data()
      );

      return userType;

    }
    
    
    //errors for signing in
    String printError(FirebaseAuthException e) {
      if (e.code == 'weak-password') {
        return 'The password is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else if (e.code == 'invalid-email') {
        return 'Please enter a valid email address.';
      } else if (e.code == 'user-not-found') {
        return 'There is no user by this email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password. Please try again.';
      } else {
        return 'Unknown Error: Please try again.';
      }
    }

    //checks if login is successful
    Future<bool> firebaseSignIn(String email, String password) async {
      try {

        UserCredential userCredential =
        await auth.signInWithEmailAndPassword(email: email, password: password)
        .then( (result) {
          FirebaseFirestore.instance.collection('users').doc(email).get()
            .then( (value) {
              var userType = value.data()['role'];
              if (userType == 'admin') {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => AdminHomePage(email: email)));
              }
              else if (userType == 'customer') {
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
              }
          });
          return;
        });
        return true;

      } on FirebaseAuthException catch (e) {
        _error = printError(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_error)));
        return false;
      } catch (e) {
        return false;
      }


    }

}