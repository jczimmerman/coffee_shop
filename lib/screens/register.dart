import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

//errors for creating account
void printError(FirebaseAuthException e) {
  if (e.code == 'weak-password') {
    print('The password is too weak.');
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
  } else if (e.code == 'invalid-email') {
    print('Please enter a valid email address.');
  } else if (e.code == 'user-not-found') {
    print('There is no user by this email.');
  } else if (e.code == 'wrong-password') {
    print('Wrong password. Please try again.');
  }
}

//checks if account is valid
Future<bool> firebaseSignUp(String email, String password) async {
  try {
    UserCredential userCredential =
    await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    return true;
  } on FirebaseAuthException catch(e) {
    printError(e);
    return false;
  } catch (e) {
    print(e);
    return false;
  }
}

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>{
  String _email, _password;
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
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
                firebaseSignUp(_email, _password);
                Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('Register')
          ),
        ],
      ),
    );
  }
}