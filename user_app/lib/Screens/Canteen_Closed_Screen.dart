import 'package:flutter/material.dart';

class Closed extends StatefulWidget {
  @override
  _ClosedState createState() => _ClosedState();
}

class _ClosedState extends State<Closed> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  height: 200,
                  width: 300,
                  child: Image.asset(
                    'assets/images/closeddown.jpg',
                    height: 200,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "The canteen is closed",
                style: TextStyle(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
