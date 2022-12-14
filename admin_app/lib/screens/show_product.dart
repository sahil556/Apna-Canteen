import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShowProduct extends StatefulWidget {
  ShowProduct();

  @override
  VideoScreenState createState() => VideoScreenState();
}

String mrp;
String name;
String description;
String available;
String category;
String id;

class VideoScreenState extends State<ShowProduct> {
  VideoScreenState();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _catController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _availController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchUserInfo();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView(
              children: snapshot.data.docs.map((document) {
                mrp = document['price'].toString();
                name = document['name'];
                description = document['description'];
                category = document['category'];
                available = document['available'];
                id = document['id'].toString();
                return Center(
                  child: Container(
                    padding: EdgeInsets.all(10),
                    margin: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white),
                    child: Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 1.2,
                          height: MediaQuery.of(context).size.height / 6,
                          child: Text("\nName : " +
                              name +
                              '\n' +
                              "Description : " +
                              description +
                              "\nProduct category : " +
                              category +
                              "\nPrice is : " +
                              mrp +
                              '\n' +
                              "Availaible : " +
                              available +
                              '\n'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 18),
                          child: Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  openDialogueBox(
                                      context,
                                      document['id'],
                                      document['name'],
                                      document['description'],
                                      document['price'].toString());
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green, // Background color
                                ),
                              ),
                              // IconButton(
                              //   Icons.edit,
                              //   iconSize: 20,
                              //   onPressed: openDialogueBox(context) ,
                              // ),
                              SizedBox(
                                width: 20,
                              ),
                              // IconButton(
                              //   Icons.delete,
                              //   onPressed: ,
                              //   iconSize: 20,
                              // ),
                              ElevatedButton(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: Text(
                                              'Are you want to delete this product?'),
                                          actions: [
                                            ElevatedButton(
                                              onPressed: () {
                                                _deleteProduct(document['id']);
                                                submitAction(context);
                                                Navigator.pop(context);
                                              },
                                              child: Text('Yes'),
                                            ),
                                            ElevatedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Cancel'),
                                            )
                                          ],
                                        );
                                      });
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.red, // Background color
                                ),
                              ),
                              IconButton(
                                  icon: Icon(Icons.food_bank),
                                  onPressed: () {
                                    _updateToY(document['id']);
                                    submitAction(context);
                                  }),
                              IconButton(
                                  icon: Icon(Icons.food_bank_outlined),
                                  onPressed: () {
                                    _updateToN(document['id']);
                                  })
                            ],
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

  openDialogueBox(BuildContext context, String _id, String _name,
      String _description, String _price) {
    _nameController.text = _name;
    _descController.text = _description;
    _priceController.text = _price;
    print(_id);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Edit Product Details'),
            content: Container(
              height: 240,
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(hintText: 'Name'),
                  ),
                  TextFormField(
                    controller: _descController,
                    decoration: InputDecoration(hintText: 'Description'),
                  ),
                  TextFormField(
                    controller: _priceController,
                    decoration: InputDecoration(hintText: 'price'),
                  ),
                  // TextField(
                  //   controller: _catController,
                  //   decoration: InputDecoration(hintText: 'category'),
                  // ),
                  // TextFormField(
                  //   controller: _availController,
                  //   decoration: InputDecoration(hintText: 'Y/N'),
                  // ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () async {
                  await _updateProducts(
                    _id,
                    this._nameController.text,
                    this._descController.text,
                    this._priceController.text,
                    // this._catController.text,
                    // this._availController.text,
                  );
                  submitAction(context);
                  Fluttertoast.showToast(msg: 'Product Updated');
                  Navigator.pop(context);
                },
                child: Text('Submit'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              )
            ],
          );
        });
  }

  Future<void> _updateProducts(
      String id, String _name, String _desc, String _price) async {
    try {
      await FirebaseFirestore.instance.collection('products').doc(id).update({
        'name': _name,
        'description': _desc,
        'price': int.parse(_price),
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void _updateToY(String id) {
    FirebaseFirestore.instance.collection('products').doc(id).update({
      'available': 'Y',
    });
  }

  void _updateToN(String id) {
    FirebaseFirestore.instance.collection('products').doc(id).update({
      'available': 'N',
    });
  }

  void _deleteProduct(String id) {
    try {
      FirebaseFirestore.instance.collection('products').doc(id).delete();
    } catch (e) {
      print(e.toString());
    }
  }

  fetchUserInfo() async {
    // ignore: await_only_futures
    User getUser = await FirebaseAuth.instance.currentUser;
    // userID = getUser.uid;
  }

  submitAction(BuildContext context) {
    // updateData(_nameController.text, _descController.text,_catController.text,
    //     int.parse(_priceController.text), _availController.text,userID);
    _nameController.clear();
    _descController.clear();
    _catController.clear();
    _priceController.clear();
    _availController.clear();
  }
}
