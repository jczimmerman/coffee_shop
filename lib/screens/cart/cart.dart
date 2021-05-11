import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/screens/menus/coffee_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class Cart extends StatelessWidget {
  final email;
  const Cart({Key key, this.email}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          Container(
            child: IconButton(
                icon: Icon(Icons.shopping_cart_outlined),
                onPressed: () {

                }
            )
          ),
        ],
      ),
      body: CartItems(email: email)
    );
  }
}

Future getItems(String email) async {
  var instance = FirebaseFirestore.instance;

  QuerySnapshot qn = await instance.collection('carts').doc(email).collection('items').get();
  return qn.docs;
}

class CartItems extends StatefulWidget {
  final email;
  const CartItems({Key key, this.email}) : super(key: key);


  @override
  _CartItemsState createState() => _CartItemsState(email);
}

class _CartItemsState extends State<CartItems> {
  final email;
  _CartItemsState(this.email);
  int _total = 0;

  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
          future: getItems(email),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('Loading...'),
              );
            } else {
              return Column(
                children: [
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        _total += snapshot.data[index]['price'];
                        return Container(
                          child: Row(
                            children: [
                              Expanded(
                                child: Card(
                                    child: ListTile(
                                      //add image
                                      //leading: Image.network(snapshot.data[index]['picture']),
                                      title: Text(
                                        snapshot.data[index]['name'],
                                        style: TextStyle(
                                        ),
                                      ),
                                      subtitle: Text(snapshot.data[index]['description']),
                                    )
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  children: [
                                    Text(
                                        'Amount:'
                                    ),
                                    Text(
                                        snapshot.data[index]['amount'].toString()
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Column(
                                  children: [
                                    Text(
                                        'Price:'
                                    ),
                                    Text(
                                        snapshot.data[index]['price'].toString()
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 10, right: 10),
                                  child: GestureDetector(
                                    child: Text(
                                      'Remove',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 16
                                      ),
                                    ),
                                    onTap: () async {
                                      //remove document from collection
                                      await FirebaseFirestore.instance.runTransaction( (Transaction myTransaction) async {
                                        await myTransaction.delete(snapshot.data[index].reference);
                                      });

                                      setState(() {
                                        color = color == Colors.white ? Colors.grey : Colors.white;
                                      });
                                    },
                                  )
                              )
                            ],
                          ),
                        );
                      }
                  ),

                  Row(
                    children: [
                      Container(
                        child: Text(
                          'Your total: '
                        ),
                      ),
                      Container(
                        child: Text(
                          _total.toString()
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20 ),
                    padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Colors.blue
                    ),
                    child: GestureDetector(
                      onTap: () {
                        //remove items from stock
                        FirebaseFirestore.instance.collection('carts').doc(email).collection('items').get()
                        .then( (snapshot) {
                          for (DocumentSnapshot ds in snapshot.docs) {
                            //remove stock from coffee_menu
                            FirebaseFirestore.instance.collection('coffee_menu').doc(ds.data()['name']).update({ 'stock': FieldValue.increment(-ds.data()['amount'])})
                            .then( (val) => print('success'))
                            .catchError( (error) => print('error'));

                            //remove stock from tea_menu
                            FirebaseFirestore.instance.collection('tea_menu').doc(ds.data()['name']).update({ 'stock': FieldValue.increment(-ds.data()['amount'])})
                            .then( (val) => print('success'))
                            .catchError( (error) => print('error'));

                            //remove stock from dessert_menu
                            FirebaseFirestore.instance.collection('dessert_menu').doc(ds.data()['name']).update({ 'stock': FieldValue.increment(-ds.data()['amount'])})
                            .then( (val) => print('success'))
                            .catchError( (error) => print('error'));

                            //remove stock from pastry_menu
                            FirebaseFirestore.instance.collection('pastry_menu').doc(ds.data()['name']).update({ 'stock': FieldValue.increment(-ds.data()['amount'])})
                            .then( (val) => print('success'))
                            .catchError( (error) => print('error'));
                          }
                        });

                        //remove items from cart
                        FirebaseFirestore.instance.collection('carts').doc(email).collection('items').get()
                        .then( (snapshot) {
                          for (DocumentSnapshot ds in snapshot.docs) {
                            ds.reference.delete();
                          }
                        });

                        //navigate to home
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Checkout',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24
                        ),
                      ),
                    ),
                  )
                ],
              );
            }
          },
        )
    );
  }
}



