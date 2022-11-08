import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String user;
String clientSecret =
    'sk_test_51HluzeJxRLNJ0BeCNbIcKdX8ndyfZvbP37UeshnfExWZDaFOnh0mqsEaI0uzjpqUHKUGcAor9Z1pZeJVduFgkPpu00fPVkpWVE';

TextEditingController amountController = TextEditingController();
bool _validate = false;

var themeColorYellow = Color(0xffCEA972);
var themeColorGrey = Color(0xff656567);

bool isValidEmail(String email) {
  bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
  return emailValid;
}

buildErrorDialog(BuildContext context, String title, String content) {
  Widget okButton = TextButton(
    style: TextButton.styleFrom(backgroundColor: Colors.transparent),
    child: Text("OK",
        style: TextStyle(
            color: Colors.black,
            decorationColor: Colors.black,
            fontFamily: 'poppins')),
    onPressed: () {
      Navigator.pop(context);
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
