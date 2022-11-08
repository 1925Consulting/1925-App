import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consulting1925/services/firebase.dart';
import 'package:consulting1925/services/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class AboutUsScreen extends StatefulWidget {
  @override
  _AboutUsScreenState createState() => _AboutUsScreenState();
}

class _AboutUsScreenState extends State<AboutUsScreen> {
  ScrollController _scrollController;
  Color _theme;

  @override
  void initState() {
    _theme = Colors.black;

    _scrollController = ScrollController()
      ..addListener(
            () => _isAppBarExpanded
            ? _theme != Colors.white
                ? setState(
                    () {
                      _theme = Colors.white;
                      print('setState is called');
                    },
                  )
                : {}
            : _theme != Colors.black
                ? setState(() {
                    print('setState is called');
                    _theme = Colors.black;
                  })
                : {},
      );
    super.initState();
  }

  bool get _isAppBarExpanded {
    return _scrollController.hasClients &&
        _scrollController.offset > (200 - kToolbarHeight);
  }

  @override
  Widget build(BuildContext context) {
    Color itemColor = _isAppBarExpanded ? themeColorYellow : Colors.transparent;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/login-bg.png"),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: CustomScrollView(
              controller: _scrollController,
              primary: false,
              physics: ClampingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  elevation: 0.0,
                  forceElevated: false,
                  backgroundColor: itemColor,
                  pinned: true,
                  centerTitle: true,
                  collapsedHeight: AppBar().preferredSize.height,
                  expandedHeight: 200,
                  iconTheme: IconThemeData(color: Colors.white),
                  floating: true,
                  flexibleSpace: FlexibleSpaceBar(
                    collapseMode: CollapseMode.pin,
                    centerTitle: true,
                    title: Text(
                      !_isAppBarExpanded ? '' : 'About Us',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 20),
                    ),
                    background: Container(),
                  ),
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  fillOverscroll: true,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SingleChildScrollView(
                      primary: false,
                      clipBehavior: Clip.hardEdge,
                      physics: NeverScrollableScrollPhysics(),
                      child: Stack(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.only(top: 15.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(
                                        ResponsiveFlutter.of(context)
                                            .scale(50.0)),
                                    topLeft: Radius.circular(
                                        ResponsiveFlutter.of(context)
                                            .scale(50.0)))),
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveFlutter.of(context).wp(8.0),
                              vertical: ResponsiveFlutter.of(context).hp(5.0),
                            ),
                            child: StreamBuilder<DocumentSnapshot>(
                              stream: getAboutUsContent(),
                              builder: (context,
                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  Map<String, dynamic> map =
                                      snapshot.data.data();
                                  print(snapshot.data.data().toString());
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        child: Text(
                                          'About Us',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 18),
                                        ),
                                      ),
                                      Container(
                                        child: Text(
                                          map['title'],
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0))),
                                        child: Text(
                                          '\n' +
                                              map['description']
                                                  .toString()
                                                  .replaceAll("\\n", "\n"),
                                          style: TextStyle(
                                              fontWeight: FontWeight.normal,
                                              color: Colors.black
                                                  .withOpacity(0.7)),
                                        ),
                                      ),
                                    ],
                                  );
                                } else {
                                  return Center(
                                    child: Container(
                                      child: Platform.isAndroid
                                          ? CircularProgressIndicator()
                                          : CupertinoActivityIndicator(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                top: ResponsiveFlutter.of(context).hp(0.0)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: ResponsiveFlutter.of(context).wp(15.0),
                                  height:
                                      ResponsiveFlutter.of(context).wp(15.0),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle),
                                  child: Center(
                                    child: Image.asset(
                                        "assets/images/logo-selected.png",
                                        width: ResponsiveFlutter.of(context)
                                            .wp(8.0),
                                        height: ResponsiveFlutter.of(context)
                                            .wp(8.0),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
