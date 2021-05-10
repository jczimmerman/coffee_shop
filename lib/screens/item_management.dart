import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'item_add.dart';

class ItemPage extends StatefulWidget {
  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  Color color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item Management'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }
            );
          },
        )
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10, bottom: 10),
                  child: Center(
                    child: GestureDetector(
                      onTap: () async{
                        final value = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ItemAdd(),
                          ),
                        );

                        //test
                        setState(() {
                          color = color == Colors.white ? Colors.grey : Colors.white;
                        });
                      },
                      child: Text(
                        'Create Item',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 20
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.grey
                  ),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      'Coffee Items',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white
                      ),
                    ),
                  ),
                ),
                CoffeeMenu(),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey
                    ),
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        'Tea Items',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white
                        ),
                      ),
                    )
                ),
                TeaMenu(),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey
                    ),
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        'Dessert Items',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white
                        ),
                      ),
                    )
                ),
                DessertMenu(),
                Container(
                    decoration: BoxDecoration(
                        color: Colors.grey
                    ),
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        'Pastry Items',
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.white
                        ),
                      ),
                    )
                ),
                PastryMenu()
              ],
            ),
          )
        ],
      )
    );
  }
}

//helper function to get all current items
Future getItems(String type) async {
  var instance = FirebaseFirestore.instance;

  QuerySnapshot qn = await instance.collection(type).get();
  return qn.docs;
}

//coffee list
class CoffeeMenu extends StatefulWidget {
  @override
  _CoffeeMenuState createState() => _CoffeeMenuState();
}

class _CoffeeMenuState extends State<CoffeeMenu> {
  final type = 'coffee_menu';


  @override
  Widget build(BuildContext context) {
    return Container(
      child: FutureBuilder(
        future: getItems(type),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('Loading...'),
            );
          } else {
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.data.length,
              itemBuilder: (_, index) {
                return Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                              child: ListTile(
                                leading: Image.network(snapshot.data[index]['picture']),
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
                                'Price',
                                style: TextStyle(

                                ),
                              ),
                              Text(
                                  snapshot.data[index]['price'].toString()
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: [
                              Text(
                                'Stock',
                                style: TextStyle(

                                ),
                              ),
                              Text(
                                  snapshot.data[index]['stock'].toString()
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Center(
                            child: GestureDetector(
                              onTap: () async {
                                await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                  // delete item
                                  await myTransaction.delete(snapshot.data[index].reference);
                                });

                                //update state to show changes
                                setState(() {});
                              },
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.red
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                );
              },
            );
          }
        },
      )
    );
  }
}


//tea list
class TeaMenu extends StatefulWidget {
  @override
  _TeaMenuState createState() => _TeaMenuState();
}

class _TeaMenuState extends State<TeaMenu> {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
          future: getItems('tea_menu'),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('Loading...'),
              );
            } else {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                              child: ListTile(
                                leading: Image.network(snapshot.data[index]['picture']),
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
                                'Price',
                                style: TextStyle(

                                ),
                              ),
                              Text(
                                  snapshot.data[index]['price'].toString()
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: [
                              Text(
                                'Stock',
                                style: TextStyle(

                                ),
                              ),
                              Text(
                                  snapshot.data[index]['stock'].toString()
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Center(
                            child: GestureDetector(
                              onTap: () async {
                                await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                  await myTransaction.delete(snapshot.data[index].reference);
                                });

                                //update state to show changes
                                setState(() {});
                              },
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
          },
        )
    );
  }
}

//dessert items
class DessertMenu extends StatefulWidget {
  @override
  _DessertMenuState createState() => _DessertMenuState();
}

class _DessertMenuState extends State<DessertMenu> {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
          future: getItems('dessert_menu'),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('Loading...'),
              );
            } else {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                              child: ListTile(
                                leading: Image.network(snapshot.data[index]['picture']),
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
                                'Price',
                                style: TextStyle(

                                ),
                              ),
                              Text(
                                  snapshot.data[index]['price'].toString()
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: [
                              Text(
                                'Stock',
                                style: TextStyle(

                                ),
                              ),
                              Text(
                                  snapshot.data[index]['stock'].toString()
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Center(
                            child: GestureDetector(
                              onTap: () async {
                                await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                  await myTransaction.delete(snapshot.data[index].reference);
                                });

                                //update state to show changes
                                setState(() {});
                              },
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
          },
        )
    );
  }
}


//pastry items
class PastryMenu extends StatefulWidget {
  @override
  _PastryMenuState createState() => _PastryMenuState();
}

class _PastryMenuState extends State<PastryMenu> {

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FutureBuilder(
          future: getItems('pastry_menu'),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text('Loading...'),
              );
            } else {
              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (_, index) {
                  return Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: Card(
                              child: ListTile(
                                leading: Image.network(snapshot.data[index]['picture']),
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
                                'Price',
                                style: TextStyle(

                                ),
                              ),
                              Text(
                                  snapshot.data[index]['price'].toString()
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Column(
                            children: [
                              Text(
                                'Stock',
                                style: TextStyle(

                                ),
                              ),
                              Text(
                                  snapshot.data[index]['stock'].toString()
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
                          child: Center(
                            child: GestureDetector(
                              onTap: () async {
                                await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                  await myTransaction.delete(snapshot.data[index].reference);
                                });

                                //update state to show changes
                                setState(() {});
                              },
                              child: Text(
                                'Delete',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.red
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }
          },
        )
    );
  }
}
