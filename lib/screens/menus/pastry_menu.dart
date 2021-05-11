import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop/screens/cart/cart.dart';


class PastryMenu extends StatefulWidget {
  final email;

  const PastryMenu({Key key, this.email}) : super(key: key);


  @override
  _PastryMenuState createState() => _PastryMenuState(email);
}


class _PastryMenuState extends State<PastryMenu> {
  final email;
  _PastryMenuState(this.email);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Pastry Menu'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          },
        ),
      ),
      body: ListPage(email: email),
    );
  }
}

class ListPage extends StatelessWidget {
  final email;

  const ListPage({Key key, this.email}) : super(key: key);


  Future getPosts() async {
    var firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestoreInstance.collection("pastry_menu").get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
          future: getPosts(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading..."),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (_, index) {
                    return Container(
                      child: Card(

                        //have to align them correctly but also have to make all the other menus
                        //and link them to a cart page
                        child: ListTile(
                          leading: Image.asset(snapshot.data[index]["picture"]),
                          title: Text(snapshot.data[index]["name"]),
                          subtitle: Column(
                              children: <Widget> [
                                Container(
                                    child: Text(snapshot.data[index]["description"])
                                ),
                                Container(
                                    child: Text('Price: ' + "\$" +(snapshot.data[index]["price"]).toString())
                                ),
                                Container(
                                    child: Text('Stock: ' + (snapshot.data[index]["stock"]).toString())
                                ),
                                Container(
                                    child: TextButton(
                                      child: Text("Add to Cart"),
                                      onPressed: () async {

                                        await FirebaseFirestore.instance.collection('carts').doc(email).collection('items').doc(snapshot.data[index]["name"])
                                            .update({
                                          'amount': FieldValue.increment(1),
                                          'price': FieldValue.increment(snapshot.data[index]["price"])
                                        })
                                            .then( (val) => print('Successfully edited stock.'))
                                            .catchError( (error) async => {

                                          await FirebaseFirestore.instance.collection('carts').doc(email).collection('items').doc(snapshot.data[index]["name"])
                                              .set({
                                            'amount': FieldValue.increment(1),
                                            'price': FieldValue.increment(snapshot.data[index]["price"]),
                                            'name' : snapshot.data[index]["name"],
                                            'picture' : snapshot.data[index]["picture"],
                                            'description' : snapshot.data[index]['description']
                                          })
                                              .then( (val) => print('Successfully edited stock.'))
                                              .catchError( (error) => print('Error: $error'))

                                        });

                                      },
                                    )
                                ),
                              ]
                          ),
                        ),
                      ),
                    );
                  });
            }
          }),
    );
  }
}


