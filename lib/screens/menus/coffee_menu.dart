
import 'package:coffee_shop/screens/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop/screens/cart/cart.dart';


class CoffeeItem {
  final String name;
  final num stock;
  final num price;
  CoffeeItem(this.name, this.stock, this.price);

  @override
  List toString() {
    return '{ ${this.name}, ${this.stock}, ${this.price} }';
  }
}

class CoffeeMenu extends StatefulWidget {

CoffeeMenu({this.cartItems});
final List<List> cartItems;


  @override
  _CoffeeMenuState createState() => _CoffeeMenuState();
}

class _CoffeeMenuState extends State<CoffeeMenu> {



  Future getPosts() async {
    var firestoreInstance = FirebaseFirestore.instance;
    QuerySnapshot qn = await firestoreInstance.collection("coffee_menu").get();
    return qn.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Coffee Menu'),
      ),
    body:
    Container(
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
                              children: <Widget>[
                                Container(
                                    child: Text(
                                        snapshot.data[index]["description"])
                                ),
                                Container(
                                    child: Text('Price: ' + "\$" +
                                        (snapshot.data[index]["price"])
                                            .toString())
                                ),
                                Container(
                                    child: Text('Stock: ' +
                                        (snapshot.data[index]["stock"])
                                            .toString())
                                ),
                                Container(
                                    child: TextButton(
                                      child: Text("Add to Cart"),
                                      onPressed: () {
                                        var name = snapshot.data[index]["name"];
                                        var stock = snapshot.data[index]["stock"];
                                        var price = snapshot.data[index]["price"];
                                        var item = CoffeeItem(name, stock, price);
                                         print(CoffeeItem(name, stock, price));
                                        setState(() {
                                          widget.cartItems.add(item.toString());
                                        });
                                        print(widget.cartItems);


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

    )

    );

  }
   /*void addItemToList(){
     setState(() {
       widget.cartItems.add(snapshot.data[index]["name"]);
     });
   }*/

}





