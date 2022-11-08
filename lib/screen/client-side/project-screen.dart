import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consulting1925/Model/projects-model.dart';
import 'package:consulting1925/screen/client-side/project-detail-screen.dart';
import 'package:consulting1925/screen/navigation-bar-screen.dart';
import 'package:consulting1925/services/firebase.dart';
import 'package:consulting1925/services/global.dart';
import 'package:consulting1925/services/shared-preferance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class ProjectScreen extends StatefulWidget {
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            'Project Page',
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(right: 15),
              child: GestureDetector(
                child: Icon(Icons.logout),
                onTap: () async {
                  Widget okButton = TextButton(
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });

                      await FirebaseAuth.instance.signOut();
                      await SaveDataLocal.clearDataFromLocal();

                      Navigator.of(context).pop();
                      Navigator.pushReplacement(
                          context,
                          PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  DashboardNavigation(),
                              transitionDuration: Duration(seconds: 0)));
                    },
                  );

                  // set up the AlertDialog
                  AlertDialog alert = AlertDialog(
                    title: Text("1925 Consulting"),
                    content: Text("Are you sure to logout?"),
                    actions: [
                      okButton,
                      TextButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );

                  // show the dialog
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                },
              ),
            )
          ],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 15.0),
          margin: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
          child: SingleChildScrollView(
            child: StreamBuilder(
              stream: projectData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> map = snapshot.data.data();
                  print(map);
                  return Column(
                    children: [
                      Container(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 0.0),
                          margin: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 0.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                          ),
                          width: MediaQuery.of(context).size.width,
                          child: ClipRRect(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10),
                              ),
                              // child: Image.asset(
                              //   'assets/images/project_static.png',
                              //   fit: BoxFit.cover,
                              //   scale: 3,
                              //   height: ResponsiveFlutter.of(context).hp(40),
                              //   width: MediaQuery.of(context).size.width,
                              // ),
                              child: CachedNetworkImage(
                                placeholder: (context, url) => Center(
                                  child: Platform.isAndroid
                                      ? CircularProgressIndicator()
                                      : CupertinoActivityIndicator(),
                                ),
                                imageUrl: map['image_url'].toString(),
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  height: ResponsiveFlutter.of(context).hp(40),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ))),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: ResponsiveFlutter.of(context).hp(2.0)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              map['title'].toString(),
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize:
                                    ResponsiveFlutter.of(context).fontSize(2.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ResponsiveFlutter.of(context).hp(1.5)),
                              child: Text(map['description'].toString()),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: StreamBuilder<QuerySnapshot>(
                          stream: getClientProjects(user),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              return ListView.builder(
                                primary: false,
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                padding: EdgeInsets.zero,
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (context, index) {
                                  ProjectModel projectModel =
                                      ProjectModel.fromJson(
                                          snapshot.data.docs[index].data());
                                  return InkResponse(
                                    child: projectList(projectModel),
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ProjectDetailsScreen(
                                            projectModel: projectModel,
                                            projectId:
                                                snapshot.data.docs[index].id,
                                          ),
                                        )),
                                  );
                                },
                              );
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      ),
                    ],
                  );
                } else {
                  return Center();
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget projectList(ProjectModel projectModel) {
    print(projectModel.status);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
      margin: EdgeInsets.symmetric(vertical: 00.0, horizontal: 00.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: ResponsiveFlutter.of(context).hp(8.0),
                width: ResponsiveFlutter.of(context).hp(8.0),
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: themeColorGrey, width: 0.3),
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                child: CachedNetworkImage(
                  placeholder: (context, url) => Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('assets/images/logo-selected.png'),
                          scale: 0.7),
                    ),
                  ),
                  imageUrl: projectModel.project_image,
                  imageBuilder: (context, imageProvider) => Container(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveFlutter.of(context).wp(4.0)),
                  child: Text(
                    projectModel.project_name.toString(),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

      //Redirection payment stripe
      // projectModel.balance_due.toString() == '0'
      //     ? Container()
      //     : Container(
      //         alignment: Alignment.center,
      //         child: TextButton(
      //           onPressed: () async {
      //             source = await StripePaymentInitialize().makePayment();
      //             if (source == null) {
      //               print('Erroe');
      //             } else {
      //               print(source.toJson().toString());
      //             }
      //           },
      //           child: Text(
      //             'Pay Remaining Due',
      //             style: TextStyle(color: Colors.white),
      //           ),
      //         ),
      //       ),
    );
  }

  String getFormattedDate(DateTime date) {
    if (date != null) {
      String formattedDate = DateFormat('dd MM yyyy').format(date);
      return formattedDate;
    } else {
      return "";
    }
  }
}
