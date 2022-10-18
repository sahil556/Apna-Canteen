import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/Utils/constants.dart';

void createNewUser(var name, var email) {
  FirebaseFirestore.instance
      .collection('users')
      .add({
        "email": email,
        "orders": new List<String>(),
        "name": name,
      })
      .then((result) => {
            uid = result.id,
          })
      // ignore: return_of_invalid_type_from_catch_error
      .catchError((err) => Dialog(child: Text("error" + err)));
}
