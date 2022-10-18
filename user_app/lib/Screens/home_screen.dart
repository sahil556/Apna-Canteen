import 'package:user_app/Screens/signin_screen.dart';
import 'package:user_app/widgets/best_food_widget.dart';
import 'package:user_app/widgets/bottom_navbar_widget.dart';
import 'package:user_app/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_app/widgets/display_food_widget.dart';
import '../Services/signout.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User uid = _auth.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFFFAFAFA),
          elevation: 0,
          title: Text(
            "APNA CANTEEN",
            style: TextStyle(
                color: Color(0xFF3a3737),
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          // brightness: Brightness.light,
          actions: <Widget>[
            if (uid != null)
              Icon(
                Icons.verified_user,
                color: Color(0xFF3a3737),
              ),
            uid != null
                ? IconButton(
                    icon: Icon(
                      Icons.logout,
                      color: Color(0xFF3a3737),
                    ),
                    onPressed: () {
                      signOut(context);
                    })
                : IconButton(
                    icon: Icon(
                      Icons.login,
                      color: Color(0xFF3a3737),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SignInPage()));
                    })
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SearchWidget(),
              Text(
                "All Food Items",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF3a3a3b),
                    fontWeight: FontWeight.w300),
              ),
              DisplayFoodItems(),
              Text(
                "Sort by category",
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 20,
                    color: Color(0xFF3a3a3b),
                    fontWeight: FontWeight.w300),
              ),
              BestFoodWidget(),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(),
      ),
    );
  }
}
