import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PricePage extends StatefulWidget {
  @override
  _PricePageState createState() => _PricePageState();
}

class _PricePageState extends State<PricePage> {
  Color color = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Price Management'),
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
                    decoration: BoxDecoration(
                        color: Colors.grey
                    ),
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        'Coffee Items - Price',
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
                          'Tea Items - Price',
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
                          'Dessert Items - Price',
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
                          'Pastry Items - Price',
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
  int _price;

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
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Expanded(
                                child: Column(
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                          labelText: snapshot.data[index]['price'].toString()
                                      ),
                                      onChanged: (val) {
                                        _price = int.tryParse(val);
                                      },
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10, right: 10),
                                      child: GestureDetector(
                                        onTap: () async {
                                          await FirebaseFirestore.instance.collection(type).doc(snapshot.data[index]['name'])
                                              .update({
                                            'price': _price
                                          })
                                          .then( (val) => print('Successfully edited price.'))
                                          .catchError( (error) => 'Error: $error');

                                          //set state
                                          setState(() {});
                                        },
                                        child: Text(
                                          'Update',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 16
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
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
  final type = 'tea_menu';
  int _price;

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
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Expanded(
                                child: Column(
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                          labelText: snapshot.data[index]['price'].toString()
                                      ),
                                      onChanged: (val) {
                                        _price = int.tryParse(val);
                                      },
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10, right: 10),
                                      child: GestureDetector(
                                        onTap: () async {
                                          await FirebaseFirestore.instance.collection(type).doc(snapshot.data[index]['name'])
                                              .update({
                                            'price': _price
                                          })
                                              .then( (val) => print('Successfully edited price.'))
                                              .catchError( (error) => 'Error: $error');

                                          //set state
                                          setState(() {});
                                        },
                                        child: Text(
                                          'Update',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 16
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
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
  final type = 'dessert_menu';
  int _price;

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
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Expanded(
                                child: Column(
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                          labelText: snapshot.data[index]['price'].toString()
                                      ),
                                      onChanged: (val) {
                                        _price = int.tryParse(val);
                                      },
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10, right: 10),
                                      child: GestureDetector(
                                        onTap: () async {
                                          await FirebaseFirestore.instance.collection(type).doc(snapshot.data[index]['name'])
                                              .update({
                                            'price': _price
                                          })
                                              .then( (val) => print('Successfully edited price.'))
                                              .catchError( (error) => 'Error: $error');

                                          //set state
                                          setState(() {});
                                        },
                                        child: Text(
                                          'Update',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 16
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
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
  final type = 'pastry_menu';
  int _price;

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
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left: 10, right: 10),
                              child: Expanded(
                                child: Column(
                                  children: [
                                    TextField(
                                      decoration: InputDecoration(
                                          labelText: snapshot.data[index]['price'].toString()
                                      ),
                                      onChanged: (val) {
                                        _price = int.tryParse(val);
                                      },
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(left: 10, right: 10),
                                      child: GestureDetector(
                                        onTap: () async {
                                          await FirebaseFirestore.instance.collection(type).doc(snapshot.data[index]['name'])
                                              .update({
                                            'price': _price
                                          })
                                              .then( (val) => print('Successfully edited price.'))
                                              .catchError( (error) => 'Error: $error');

                                          //set state
                                          setState(() {});
                                        },
                                        child: Text(
                                          'Update',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 16
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
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