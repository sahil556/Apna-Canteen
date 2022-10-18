import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:user_app/Screens/feedback_screen.dart';
import 'package:user_app/Services/submit_feedback.dart';

class SubmitFeedbackButton extends StatelessWidget {
  final String feedback;

  SubmitFeedbackButton({Key key, this.feedback}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Color(0xFFfbab66),
          ),
          BoxShadow(
            color: Color(0xFFf7418c),
          ),
        ],
        gradient: new LinearGradient(
            colors: [Color(0xFFf7418c), Color(0xFFfbab66)],
            begin: const FractionalOffset(0.2, 0.2),
            end: const FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: MaterialButton(
          highlightColor: Colors.transparent,
          splashColor: Color(0xFFf7418c),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 32.0),
            child: Text(
              "SUBMIT",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontFamily: "WorkSansBold"),
            ),
          ),
          onPressed: () async => {
                if (feedback == "")
                  {
                    Fluttertoast.showToast(msg: 'Please Enter Your Feedback'),
                  }
                else
                  {
                    await submitFeedback(feedback),
                    Fluttertoast.showToast(msg: 'Feedback Submitted'),
                    feedbackController.clear()
                  }
              }),
    );
  }
}
