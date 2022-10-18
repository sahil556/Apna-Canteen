import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../Services/add_to_cart.dart';

class DisplayFoodItems extends StatefulWidget {
  DisplayFoodItems();
  @override
  VideoScreenState createState() => VideoScreenState();
}

int ItemCount = 1;
TextEditingController Quantity = new TextEditingController(text: "1");

class VideoScreenState extends State<DisplayFoodItems> {
  VideoScreenState();

  @override
  void _increment() {
    if (ItemCount <= 50) {
      setState(() {
        Quantity.text = (int.parse(Quantity.text.toString()) + 1).toString();
        ItemCount++;
      });
    }
  }

  void _decrement() {
    if (ItemCount > 1) {
      setState(() {
        Quantity.text = (int.parse(Quantity.text.toString()) - 1).toString();
        ItemCount--;
      });
    }
  }

  bool CheckuserLogin() {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User uid = _auth.currentUser;
    if (uid != null) {
      return true;
    } else {
      final snackBar = SnackBar(
        content: Text("Please Login First "),
        backgroundColor: Color.fromARGB(255, 198, 45, 96),
        behavior: SnackBarBehavior.floating,
        action: SnackBarAction(
          label: 'close',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
  }

  Widget build(BuildContext context) {
    return Container(
      height: 270,
      child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              scrollDirection: Axis.horizontal,
              children: snapshot.data.docs.map((document) {
                if (document['available'] == 'N') {
                  return Center(
                    child: Container(
                      height: 0,
                      width: 0,
                    ),
                  );
                }
                return Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.only(
                          left: 10, right: 5, top: 5, bottom: 5),
                      decoration: BoxDecoration(boxShadow: []),
                      child: Card(
                        color: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Center(
                          child: Image.network(
                        document['images'][0].toString(),
                        width: 130,
                        height: 100,
                      )),
                    ),
                    ElevatedButton(
                        child: Text("add to cart"),
                        onPressed: () {
                          if (CheckuserLogin())
                            showDialog(
                              builder: (context) => new Dialog(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0))),
                                child: Container(
                                  height: 300,
                                  child: new Column(
                                    children: <Widget>[
                                      Padding(padding: EdgeInsets.all(30)),
                                      Text(
                                        "Name: " + document['name'].toString(),
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Price: " +
                                            document['price'].toString(),
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        "Quantity:",
                                        style: TextStyle(fontSize: 20),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(10),
                                        child: new Center(
                                          child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              Container(
                                                width: 35,
                                                height: 35,
                                                child: new FloatingActionButton(
                                                  onPressed: _decrement,
                                                  child: new Icon(
                                                    Icons.remove,
                                                    color: Colors.black,
                                                  ),
                                                  backgroundColor: Colors.white,
                                                ),
                                              ),
                                              Container(
                                                  width: 20,
                                                  height: 10,
                                                  child: new TextField(
                                                    controller: Quantity,
                                                  )),
                                              Container(
                                                width: 35,
                                                height: 35,
                                                child: new FloatingActionButton(
                                                  onPressed: _increment,
                                                  child: new Icon(Icons.add,
                                                      color: Colors.black),
                                                  backgroundColor: Colors.white,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      new ElevatedButton(
                                          child: new Text(
                                            "Add",
                                            style: TextStyle(
                                              fontSize: 25.0,
                                              color: Color.fromARGB(
                                                  255, 247, 241, 241),
                                              backgroundColor:
                                                  Colors.blueAccent,
                                            ),
                                          ),
                                          onPressed: () {
                                            addToCart(
                                                document['name'],
                                                document['price'],
                                                context,
                                                ItemCount);

                                            ItemCount = 1;
                                            Quantity.text = "1";
                                          }),
                                    ],
                                  ),
                                ),
                              ),
                              context: context,
                            );
                        }),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(left: 5, top: 5),
                          child: Text(document['name'],
                              style: TextStyle(
                                  color: Color(0xFF6e6e71),
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500)),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.bottomLeft,
                          padding: EdgeInsets.only(left: 5, top: 5, right: 5),
                          child: Text('Rs. ' + document['price'].toString(),
                              style: TextStyle(
                                  color: Color(0xFF6e6e71),
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                  ],
                );
              }).toList(),
            );
          }),
    );
  }
}
