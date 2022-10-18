import 'package:user_app/Utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_app/widgets/bottom_navbar_widget.dart';

class ShowOrders extends StatefulWidget {
  ShowOrders();

  @override
  Orders createState() => Orders();
}

String amount1;
String orderid1;
String payment1;
String user1;
String tempuser1;
String temporderid1;
String datetime1;
List<String> items1 = new List<String>();
List<int> quantity1 = new List<int>();

class Orders extends State<ShowOrders> {
  Orders();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Orders List',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .orderBy('datetime', descending: true)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView(
                //reverse: true,
                children: snapshot.data.docs.map((document) {
              amount1 = document['amount'].toString();
              orderid1 = document['orderid'].toString();
              payment1 = document['payment'].toString();
              if (payment1 == 'true') payment1 = 'Done';
              if (payment1 == 'false') payment1 = 'Pending';
              user1 = document['user'];
              items1 = List.from(document['items']);
              print('0');
              datetime1 =
                  DateTime.parse(document['datetime'].toDate().toString())
                      .toString();

              // quantity = List.from(document['quantity']);
              return Center(
                  child: Container(
                padding: EdgeInsets.all(8),
                margin: EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1),
                  color: Colors.orange[100],
                ),
                child: Column(children: [
                  if (document['user'] == currentUser)
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      margin: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width / 1.2,
                      //height: MediaQuery.of(context).size.height / 6,
                      child: Text(
                        "\nOrder id : " +
                            orderid1 +
                            "\nAmount is : " +
                            amount1 +
                            "\nPayment : " +
                            payment1 +
                            "\nDate-Time : " +
                            datetime1,
                        style: TextStyle(fontSize: 15),
                      ),
                    )
                  else
                    Container(
                      padding: EdgeInsets.all(0),
                      margin: EdgeInsets.zero,
                      color: Colors.green,
                      height: 0,
                      width: 0,
                    ),
                  if (document['status'] == 'a' &&
                      document['user'] == currentUser)
                    Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(children: [
                          for (int i = 0; i < items1.length; i++)
                            Text(
                                items1[i].toString() +
                                    " - " +
                                    document['quantity'][i].toString(),
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold)),
                          Text(
                            '\nOrdered and waiting for confitmation.\n',
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )
                        ]))
                  else if (document['status'] == 'b' &&
                      document['user'] == currentUser)
                    Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(children: [
                          for (int i = 0; i < items1.length; i++)
                            Text(items1[i].toString() +
                                " - " +
                                document['quantity'][i].toString()),
                          Text(
                            '\nOrdered rejected!',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ),
                        ]))
                  else if (document['status'] == 'c' &&
                      document['user'] == currentUser)
                    Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Column(children: [
                          for (int i = 0; i < items1.length; i++)
                            Text(items1[i].toString() +
                                " - " +
                                document['quantity'][i].toString()),
                          Text(
                            '\nFood Ready',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                          )
                        ]))
                  else
                    Container(
                      padding: EdgeInsets.all(0),
                      margin: EdgeInsets.zero,
                      color: Colors.green,
                      height: 0,
                      width: 0,
                    ),
                ]),
              ));
            }).toList());
          }
        },
      ),
      bottomNavigationBar: BottomNavBarWidget(),
    );
  }
}
