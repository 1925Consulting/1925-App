import 'dart:async';

import 'package:consulting1925/screen/navigation-bar-screen.dart';
import 'package:consulting1925/services/global.dart';
import 'package:consulting1925/services/shared-preferance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.green,
      body: Container(
        color: Colors.black87,
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              child: Image.asset("assets/images/lion-bg-black.png",
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: Image.asset(
                      "assets/images/splashscreen-logo.png",
                    ),
                  ),
                  Text(
                    "Welcome to 1925 Consulting",
                    style: TextStyle(
                        color: themeColorYellow,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10)),
                  Text(
                    "Your Resource for All Things New, Now and Revolutionary!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> startTimer() async {
    // await PushNotificationsManager().init(context);
    Timer(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashboardNavigation(),
          ));
    });
  }

  getUserData() async {
    user = await SaveDataLocal.getUserDataFromLocal();
    startTimer();
  }

  @override
  void initState() {
    getUserData();
    super.initState();
  }
}
