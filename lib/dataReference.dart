import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

final firestoreInstance = FirebaseFirestore.instance;



class CoffeeItem {

  num id;
  String name;
  num price;
  num stock;
  String description;



  getCoffeeItem() {
    firestoreInstance.collection("coffee_menu").get().then((querySnapshot) {
      querySnapshot.docs.forEach(
              (result) {
            final num id = result.data()['id'];
            final String name = result.data()['name'];
            final num price = result.data()['price'];
            final num stock = result.data()['stock'];
            final String description = result.data()['description'];
          });
    });
  }


   CoffeeItem({
     getCoffeeItem(),
    this.id, this.name, this.price, this.stock, this.description
    });


}







  List<CoffeeItem> coffee = [

  CoffeeItem()

  ];

//attempt at making a general class that returns the firestore data


