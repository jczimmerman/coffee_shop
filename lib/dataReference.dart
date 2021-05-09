import 'package:cloud_firestore/cloud_firestore.dart';

final firestoreInstance = FirebaseFirestore.instance;



firestoreInstance.collection("coffee_menu").get().then((querySnapshot) {
querySnapshot.docs.forEach((result) {
print(result.data());
