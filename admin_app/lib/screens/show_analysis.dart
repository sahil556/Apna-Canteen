import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Analysis extends StatefulWidget {
  Analysis();

  @override
  VideoScreenState createState() => VideoScreenState();
}

class VideoScreenState extends State<Analysis> {
  VideoScreenState();
  TextEditingController _nameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analysis of Products"),
      ),
      backgroundColor: Colors.grey,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('orders').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            // children:
            print("more data printing");

            List<String> items = new List<String>();
            List<int> quantity = new List<int>();
            final Map<String, int> products = {};
            int totalrecord = snapshot.data.size;
            int i = 0;
            return ListView(
              children: snapshot.data.docs.map((document) {
                items = List.from(document['items']);
                quantity = List.from(document['quantity']);

                for (int i = 0; i < items.length; i++) {
                  products[items[i]] = (products[items[i]] ?? 0) + quantity[i];
                }

                i += 1;
                int j = 0;
                // print("value of i : $i");
                if (i == totalrecord) {
                  products.forEach((key, value) {
                    items[j] = key;
                    quantity[j] = value;
                  });
                }

                return Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(
                      children: [
                        if (i == totalrecord)
                          for (var index = 0; index < 1; index++)
                            Container(
                              width: MediaQuery.of(context).size.width / 1.2,
                              height: MediaQuery.of(context).size.height / 6,
                              child: Text(
                                "\n Product :- " +
                                    items[index] +
                                    "\n sold :- " +
                                    quantity[index].toString() +
                                    "\n Analysis (adjust qty) : " +
                                    ((10 - quantity[index]) * -10).toString() +
                                    "%",
                                style: TextStyle(fontSize: 25),
                              ),
                            )
                      ],
                    ),
                  ),
                );
              }).toList(),
            );
          }),
    );
  }

  fetchUserInfo() async {
    // ignore: await_only_futures
    User getUser = await FirebaseAuth.instance.currentUser;
    // userID = getUser.uid;
  }
}
