import 'package:cloud_firestore/cloud_firestore.dart';

Future<bool> IsOpen() async {
  bool isOpen = true;

  await FirebaseFirestore.instance
      .collection("startstop")
      .doc("HhnQVuTVpNhSAL5fXmCz")
      .get()
      .then((value) {
    isOpen = value.data()['value'];
  });

  return isOpen;
}
