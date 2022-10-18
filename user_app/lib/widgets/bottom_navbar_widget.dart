import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_app/Screens/food_order_screen.dart';
import 'package:user_app/Screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:user_app/Screens/order_history_screen.dart';
import 'package:user_app/Screens/feedback_screen.dart';

class BottomNavBarWidget extends StatefulWidget {
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

int _selectedIndex = 0;

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {
  @override
  Widget build(BuildContext context) {
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

    void _onItemTapped(int index) {
      if (index == 0) {
        setState(() {
          _selectedIndex = index;

          if (_selectedIndex == 0) {
            Navigator.of(context).push(
              CupertinoPageRoute(
                fullscreenDialog: true,
                builder: (context) => HomePage(),
              ),
            );
          }
        });
      }
      if (index == 1 || index == 2 || index == 3) {
        if (CheckuserLogin()) {
          print(index);
          setState(() {
            _selectedIndex = index;
            if (_selectedIndex == 3) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FeedBack()),
              );
            }

            if (_selectedIndex == 1) {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => FoodOrderPage(),
                ),
              );
            }
            if (_selectedIndex == 2) {
              Navigator.of(context).push(
                CupertinoPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => ShowOrders(),
                ),
              );
            }
            //  navigateToScreens(index);
          });
        }
      }
    }

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(FontAwesomeIcons.steamSymbol),
          label: 'Order Status',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.feedback),
          label: 'Feedback',
        ),
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: Color(0xFFfd5352),
      onTap: _onItemTapped,
    );
  }
}
