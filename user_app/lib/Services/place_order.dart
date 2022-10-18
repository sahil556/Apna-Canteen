import 'package:user_app/Screens/order_history_screen.dart';
import 'package:user_app/Utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

bool payment = false;
String t = total.toString();
final date = new DateTime.now();
String orderid = date.toString();

void placeOrder(context) async {
  await Firebase.initializeApp();
  FirebaseFirestore.instance.collection('orders').add({
    "amount": calculateTotal(),
    "items": items,
    "user": currentUser,
    "quantity": quantity,
    "payment": payment,
    "status": "a",
    "datetime": DateTime.now(),
    "orderid": DateTime.now().toString(),
  }).then((result) => {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ShowOrders()),
        ),
        items.clear(),
        quantity.clear(),
        prices.clear(),
        total = calculateTotal(),
      });
}
