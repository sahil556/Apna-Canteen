import 'package:admin_app/screens/show_analysis.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:admin_app/database/category.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:admin_app/database/add_product.dart';
import 'package:admin_app/screens/show_category.dart';
import 'package:admin_app/screens/show_orders.dart';
import 'package:admin_app/screens/show_product.dart';
import 'package:admin_app/screens/show_feedback.dart';

enum Page { dashboard, manage }

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Page _selectedPage = Page.dashboard;
  MaterialColor active = Colors.red;
  MaterialColor notActive = Colors.grey;
  TextEditingController categoryController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  CategoryService _categoryService = CategoryService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.dashboard);
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color: _selectedPage == Page.dashboard
                            ? active
                            : notActive,
                      ),
                      label: Text('Dashboard'))),
              Expanded(
                  child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.manage);
                      },
                      icon: Icon(
                        Icons.sort,
                        color:
                            _selectedPage == Page.manage ? active : notActive,
                      ),
                      label: Text('Manage'))),
            ],
          ),
          elevation: 0.0,
          backgroundColor: Colors.white,
        ),
        body: _loadScreen());
  }

  Widget _loadScreen() {
    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: <Widget>[
            ElevatedButton.icon(
              onPressed: () {
                _startAlert();
              },
              icon: Icon(
                Icons.restaurant,
                size: 30.0,
                color: Color.fromARGB(255, 111, 207, 114),
              ),
              label: Text('Start Canteen',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 30.0,
                      color: Color.fromARGB(255, 111, 207, 114))),
            ),
            ElevatedButton.icon(
              onPressed: () {
                _stopAlert();
              },
              icon: Icon(
                Icons.restaurant,
                size: 30.0,
                color: Colors.red,
              ),
              label: Text('Close Canteen',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30.0, color: Colors.red)),
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Card(
                        child: GestureDetector(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.category,
                              size: 50,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Categories",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ShowCategory()));
                      },
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Card(
                        child: GestureDetector(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.emoji_food_beverage,
                              size: 50,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Products",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ShowProduct()));
                      },
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Card(
                        child: GestureDetector(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              size: 50,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Orders",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ShowOrders()));
                      },
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Card(
                        child: GestureDetector(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.feedback_rounded,
                              size: 50,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Feedback",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => ShowFeedback()));
                      },
                    )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: Card(
                        child: GestureDetector(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.analytics,
                              size: 50,
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Analysis",
                              style: TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (_) => Analysis()));
                      },
                    )),
                  ),
                ],
              ),
            ),
          ],
        );
        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.add),
              title: Text("Add product"),
              onTap: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => AddProduct()));
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.add_circle),
              title: Text("Add category"),
              onTap: () {
                _categoryAlert();
              },
            ),
          ],
        );
        break;
      default:
        return Container();
    }
  }

  void _categoryAlert() {
    var alert = new AlertDialog(
      content: Form(
        key: _categoryFormKey,
        child: TextFormField(
          controller: categoryController,
          validator: (value) {
            if (value.isEmpty) {
              return 'Category cannot be empty';
            }
          },
          decoration: InputDecoration(hintText: "Add category"),
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
            onPressed: () {
              if (categoryController.text != null) {
                _categoryService.createCategory(categoryController.text);
              }
              Fluttertoast.showToast(msg: 'category created');
              Navigator.pop(context);
            },
            child: Text('ADD')),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('CANCEL')),
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void _stopAlert() {
    try {
      FirebaseFirestore.instance
          .collection('startstop')
          .doc('HhnQVuTVpNhSAL5fXmCz')
          .update({'value': false});
    } catch (e) {
      print(e.toString());
    }
  }

  void _startAlert() {
    try {
      FirebaseFirestore.instance
          .collection('startstop')
          .doc('HhnQVuTVpNhSAL5fXmCz')
          .update({'value': true});
    } catch (e) {
      print(e.toString());
    }
  }
}
