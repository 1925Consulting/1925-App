import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consulting1925/Model/main-page-model.dart';
import 'package:consulting1925/screen/about-us-screen.dart';
import 'package:consulting1925/screen/client-side/log-in-screen.dart';
import 'package:consulting1925/screen/services-screen.dart';
import 'package:consulting1925/screen/testimonials-screen.dart';
import 'package:consulting1925/services/firebase.dart';
import 'package:consulting1925/services/global.dart';
import 'package:consulting1925/services/shared-preferance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'client-side/project-screen.dart';
import 'our-project-screen.dart';

class MainPageScreen extends StatefulWidget {
  @override
  _MainPageScreenState createState() => _MainPageScreenState();
}

class _MainPageScreenState extends State<MainPageScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new AppBar(
        title: Text(
          'Main',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        leading: new IconButton(
          icon: new Icon(Icons.menu),
          onPressed: () => _scaffoldKey.currentState.openDrawer(),
        ),
      ),
      body: StreamBuilder(
        stream: getMainPageContent(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            MainPageModel mainPageModel =
                MainPageModel.fromJson(snapshot.data.data());

            return Center(
                child: Container(
              child: Column(
                children: [Text(mainPageModel.tagline)],
              ),
            ));
          } else {
            return Container();
          }
        },
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text('Drawer Header'),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
            ),
            user != null
                ? ListTile(
                    title: Text('Projects'),
                    onTap: () {
                      // Update the state of the app.
                      // ...
                      _scaffoldKey.currentState.openEndDrawer();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjectScreen(),
                          ));
                    },
                  )
                : Container(),
            ListTile(
              title: Text('About Us'),
              onTap: () {
                // Update the state of the app.
                // ...
                _scaffoldKey.currentState.openEndDrawer();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AboutUsScreen(),
                    ));
              },
            ),
            ListTile(
              title: Text('Services'),
              onTap: () {
                // Update the state of the app.
                // ...
                _scaffoldKey.currentState.openEndDrawer();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ServiceScreen(),
                    ));
              },
            ),
            ListTile(
              title: Text('Testimonials'),
              onTap: () {
                // Update the state of the app.
                // ...
                _scaffoldKey.currentState.openEndDrawer();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TestimonialsScreen(),
                    ));
              },
            ),
            ListTile(
              title: Text('Our Projects'),
              onTap: () {
                // Update the state of the app.
                // ...
                _scaffoldKey.currentState.openEndDrawer();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OurProjectScreen(),
                    ));
              },
            ),
            user == null
                ? ListTile(
                    title: Text('Client Login'),
                    onTap: () async {
                      // Update the state of the app.
                      // ...
                      _scaffoldKey.currentState.openEndDrawer();
                      bool isLogin = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClientLoginScreen(),
                          ));
                      setState(() {});
                    },
                  )
                : ListTile(
                    title: Text('Logout'),
                    onTap: () async {
                      // Update the state of the app.
                      // ...
                      _scaffoldKey.currentState.openEndDrawer();
                      await FirebaseAuth.instance.signOut();
                      await SaveDataLocal.clearDataFromLocal();
                      setState(() {});
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
