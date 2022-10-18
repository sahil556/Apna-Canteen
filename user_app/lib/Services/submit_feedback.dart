import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/Utils/constants.dart';

submitFeedback(String feedback) {
  print(feedback);

  FirebaseFirestore.instance
      .collection('feedback')
      .add({"feedback": feedback, "name": currentUser})
      .then((result) => {})
      .catchError((err) => print(err));
}
