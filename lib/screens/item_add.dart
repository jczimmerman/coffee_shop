import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/screens/item_management.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemAdd extends StatefulWidget {

  @override
  _ItemAddState createState() => _ItemAddState();
}

class _ItemAddState extends State<ItemAdd> {
  String _description, _name, _picture, _type;
  int _price, _stock;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Add Item'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pop(context);
                }
            );
          },
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey
            ),
            padding: EdgeInsets.only(top:10, bottom: 10, left: 10),
            child: Text(
              'Select item type',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white
              ),
            ),
          ),
          new DropdownButton<String>(
            value: _type,
            hint: Text(
              'Please choose menu',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            items: <String>[
              'coffee_menu',
              'tea_menu',
              'dessert_menu',
              'pastry_menu'
            ].map((String value) {
              return new DropdownMenuItem<String>(
                value: value,
                child: new Text(value),
              );
            }).toList(),
            onChanged: (String value) {
              setState( () {
                _type = value;
              });
            },
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.grey
            ),
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
            child: Text(
              'Input item details',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
            child: TextField(
              onChanged: (String value) {
                setState(() {
                  _name = value;
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name...'
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
            child: TextField(
              onChanged: (String value) {
                setState(() {
                  _description = value;
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Description...'
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
            child: TextField(
              onChanged: (String value) {
                setState(() {
                  _picture = value;
                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Picture...'
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
            child: TextField(
              onChanged: (String value) {
                setState(() {

                  //need error handling
                  _price = int.tryParse(value);

                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Price...'
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 5, top: 5, right: 5, bottom: 5),
            child: TextField(
              onChanged: (String value) {
                setState(() {

                  //need error handling here
                  _stock = int.tryParse(value);

                });
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Stock...'
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              padding: EdgeInsets.only(top: 7, bottom: 7, left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.all(Radius.circular(5))
              ),
              child: GestureDetector(
                onTap: () async {
                  //add document to collection
                  final CollectionReference itemRef = FirebaseFirestore.instance.collection(_type);
                  await itemRef.doc(_name).set({
                    'name': _name,
                    'description': _description,
                    'picture': _picture,
                    'price': _price,
                    'stock': _stock
                  })
                  .then( (val) => print('Doc added.'))
                  .catchError( (error) => print('Failed to add doc: $error'));

                  Navigator.pop(context);
                },
                child: Text(
                    'Create Item',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25
                  ),
                ),
              )
            ),
          )
        ],
      )
    );
  }

}