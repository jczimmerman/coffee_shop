import 'package:coffee_shop/dataReference.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';




class TeaMenu extends StatefulWidget {

  @override
  _TeaMenuState createState() => _TeaMenuState();
}


class _TeaMenuState extends State<TeaMenu> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Tea Menu'),
      ),
      body: ListPage(),
    );
  }
}


class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  Future getPosts() async {
    var firestoreInstance = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestoreInstance.collection("tea_menu").get();
    return qn.docs;

  }

  //navigateToDetail(DocumentSnapshot post){
  //Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(post: post)));
  //}

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

//have to align them correctly but also have to make all the other menues
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
                                      onPressed: () {},

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

/*
class DetailPage extends StatefulWidget {

  final DocumentSnapshot post;

  DetailPage({this.post});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: ListTile(
          title: Text(widget.post["title"]),
          subtitle: Text(widget.post["description"]),
        )
      )
    );
  }
}

*/
