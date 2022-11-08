import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consulting1925/Model/projects-model.dart';
import 'package:consulting1925/services/firebase.dart';
import 'package:consulting1925/services/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import 'cardscreen.dart';

class ConfirmPaymentScreen extends StatefulWidget {
  final ProjectModel projectModel;
  final String projectId;

  const ConfirmPaymentScreen({Key key, this.projectModel, this.projectId})
      : super(key: key);

  @override
  _ConfirmPaymentScreenState createState() => _ConfirmPaymentScreenState();
}

// https://hooks.stripe.com/redirect/complete/src_1Iyt6UHOi1f8iczvebmm7Smd?client_secret=src_client_secret_Y4ccupVDWgN9lNIAXAl8zrT6&redirect_status=succeeded
class _ConfirmPaymentScreenState extends State<ConfirmPaymentScreen> {
  String paying;
  TextEditingController amount = TextEditingController();

  _ConfirmPaymentScreenState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Confirm Payment"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 20, right: 20, left: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              decoration: BoxDecoration(
                color: themeColorYellow,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total Price",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(1.8)),
                      ),
                      Text(
                        "\$" + widget.projectModel.total_charge,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(1.8)),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Paid Amount",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(1.8)),
                      ),
                      Text(
                        "\$" + widget.projectModel.balance_paid,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(1.8)),
                      )
                    ],
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Due Amount",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(1.8)),
                      ),
                      Text(
                        "\$" + widget.projectModel.balance_due,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize:
                                ResponsiveFlutter.of(context).fontSize(1.8)),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20, right: 20, left: 20),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Paying",
                    style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w400,
                        fontSize: ResponsiveFlutter.of(context).fontSize(1.8)),
                  ),
                  Container(
                    height: ResponsiveFlutter.of(context).hp(7.0),
                    width: ResponsiveFlutter.of(context).hp(14.0),
                    child: TextFormField(
                      enableInteractiveSelection: false,
                      controller: amount,
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.center,
                      onChanged: (value) {
                        paying = value == "" ? null : value;
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        hintText: '00',
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 1.0),
                        ),
                      ),
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w400,
                          fontSize:
                              ResponsiveFlutter.of(context).fontSize(1.8)),
                    ),
                  )
                ],
              ),
            ),
            Flexible(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.symmetric(
                      vertical: ResponsiveFlutter.of(context).hp(5.0),
                      horizontal: ResponsiveFlutter.of(context).hp(2.0)),
                  width: MediaQuery.of(context).size.width,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(5.0),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: ResponsiveFlutter.of(context).hp(2.0))),
                    onPressed: () async {
                      if (amount.text.isEmpty) {
                        buildErrorDialog(context, '', 'Please Enter Amount');
                      } else if (amount.text
                          .toUpperCase()
                          .contains(new RegExp(r'[A-Z]'))) {
                        buildErrorDialog(
                            context, '', 'Please Enter Proper Amount');
                      } else if (double.parse(amount.text) == null ||
                          double.parse(amount.text) < 0.50) {
                        buildErrorDialog(
                            context, '', 'Please Enter more than \$0.50');
                      } else if (double.parse(amount.text) >=
                          double.parse(widget.projectModel.balance_due)) {
                        buildErrorDialog(context, '',
                            'Amount can\'t be greater than Due Amount');
                      } else {
                        bool paymentStatus = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CardDetails(
                                amount: int.parse(amount.text) * 100,
                                projectModel: widget.projectModel,
                              ),
                            ));
                        if (paymentStatus != null && paymentStatus) {
                          print(paymentStatus);

                          double total =
                              double.parse(widget.projectModel.total_charge);
                          double paid =
                              double.parse(widget.projectModel.balance_paid);
                          double due =
                              double.parse(widget.projectModel.balance_due);

                          double paying = double.parse(this.paying);

                          if (user != null && user != "") {
                            print(user);

                            print("BEFORE");
                            print("Total: " + widget.projectModel.total_charge);
                            print("Paid: " + widget.projectModel.balance_paid);
                            print("Due: " + widget.projectModel.balance_due);

                            widget.projectModel.balance_paid =
                                (paid + paying).toString();
                            widget.projectModel.balance_due =
                                (due - paying).toString();

                            print("AFTER");
                            print("Total: " + widget.projectModel.total_charge);
                            print("Paid: " + widget.projectModel.balance_paid);
                            print("Due: " + widget.projectModel.balance_due);

                            try {
                              var result = await FirebaseFirestore.instance
                                  .collection(client)
                                  .doc(user)
                                  .collection(clientProject)
                                  .doc(widget.projectId)
                                  .update(widget.projectModel.toJson());

                              print("Done");
                            } catch (err) {
                              print(err);
                            }
                          }

                          buildPaySuccessDialog(context, 'Successful',
                              'Payment Successfully Done');
                          amount.clear();
                          paying = null;
                        } else {
                          /*buildErrorDialog(
                              context, 'Unsuccessful', 'Payment Not Completed');*/
                        }
                        setState(() {});
                      }
                    },
                    child: Text(
                      paying == null ? 'Confirm Payment' : 'Pay \$' + paying,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  buildPaySuccessDialog(BuildContext context, String title, String content) {
    Widget okButton = TextButton(
      style: TextButton.styleFrom(backgroundColor: Colors.transparent),
      child: Text("OK",
          style: TextStyle(
              color: Colors.black,
              decorationColor: Colors.black,
              fontFamily: 'poppins')),
      onPressed: () {
        Navigator.pop(context);
        Navigator.pop(context, widget.projectModel);
      },
    );

    // set up the AlertDialog

    if (Platform.isAndroid) {
      AlertDialog alert = AlertDialog(
        title: Text(title,
            style: TextStyle(
                color: Colors.black,
                decorationColor: Colors.black,
                fontFamily: 'poppins')),
        content: Text(content,
            style: TextStyle(
                color: Colors.black,
                decorationColor: Colors.black,
                fontFamily: 'poppins')),
        actions: [
          okButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
    if (Platform.isIOS) {
      CupertinoAlertDialog cupertinoAlertDialog = CupertinoAlertDialog(
        title: Text(title,
            style: TextStyle(
              color: Colors.black,
              decorationColor: Colors.black,
            )),
        content: Text(content,
            style: TextStyle(
              color: Colors.black,
              decorationColor: Colors.black,
            )),
        actions: [
          okButton,
        ],
      );
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return cupertinoAlertDialog;
        },
      );
    }
    // show the dialog
  }
}
