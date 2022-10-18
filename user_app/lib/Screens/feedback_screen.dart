import 'package:flutter/material.dart';
import 'package:user_app/Utils/constants.dart';
import 'package:user_app/widgets/bottom_navbar_widget.dart';
import 'package:user_app/widgets/feedback_widget.dart';
// this is just for illustrating

// it is absolutely fine
class FeedBack extends StatefulWidget {
  @override
  _BestFoodWidgetState createState() => _BestFoodWidgetState();
}

TextEditingController feedbackController = TextEditingController();

class _BestFoodWidgetState extends State<FeedBack> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedback',
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Center(
              child: Text(
            'Feedback ($currentUser)',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  height: 150,
                  width: MediaQuery.of(context).size.width / 1.2,
                  child: TextFormField(
                    maxLines: null,
                    controller: feedbackController,
                    decoration: new InputDecoration(
                      hintText: 'Your Feedback',
                      border: InputBorder.none,
                      fillColor: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  decoration: new BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: new Border.all(
                      color: Colors.pink,
                      width: 1.0,
                    ),
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SubmitFeedbackButton(feedback: feedbackController.text.trim()),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBarWidget(),
      ),
    );
  }
}
