/// The [dart:async] is necessary for using streams
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';



class CartItemsBloc {

  /// The [cartStreamController] is an object of the StreamController class
  /// .broadcast enables the stream to be read in multiple screens of our app
  final cartStreamController = StreamController.broadcast();

  /// The [getStream] getter would be used to expose our stream to other classes
  Stream get getStream => cartStreamController.stream;



  /// The [allItems] Map would hold all the data this bloc provides
  ///
  /// this needs to somehow grab all of the items from the database
  /// might just have to run another get function to do so?
  ///
  ///
  /*
  static void getPosts() {
    var firestoreInstance = FirebaseFirestore.instance;
    firestoreInstance.collection("coffee_menu").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        return result.data();
      });
    });
  }

  var shopItems = getPosts();

  Future getPosts2() async {
    var firestoreInstance = FirebaseFirestore.instance;

    QuerySnapshot qn = await firestoreInstance.collection("coffee_menu").get();
    return qn.docs;

  }

  getPosts();

*/

  final Map allItems = {'shop items': [
    {'name': 'App dev kit', 'price': 20, 'id': 1},
    {'name': 'App consultation', 'price': 100, 'id': 2},
    {'name': 'Logo Design', 'price': 10, 'id': 3},
    {'name': 'Code review', 'price': 90, 'id': 4},
  ],
    'cart items': []};

  /// [addToCart] adds items from the shop to the cart
  void addToCart(item) {
    allItems['shop items'].remove(item);
    allItems['cart items'].add(item);
    cartStreamController.sink.add(allItems);
  }

  /// [removeFromCart] removes items from the cart, back to the shop
  void removeFromCart(item) {
    allItems['cart items'].remove(item);
    allItems['shop items'].add(item);
    cartStreamController.sink.add(allItems);
  }

  /// The [dispose] method is used
  /// to automatically close the stream when the widget is removed from the widget tree
  void dispose() {
    cartStreamController.close(); // close our StreamController
  }
}

final bloc = CartItemsBloc();  // add to the end of the file
