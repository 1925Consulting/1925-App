import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consulting1925/Model/service-page-model.dart';
import 'package:consulting1925/screen/service-details.dart';
import 'package:consulting1925/services/firebase.dart';
import 'package:consulting1925/services/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class ServiceScreen extends StatefulWidget {
  @override
  _ServiceScreenState createState() => _ServiceScreenState();
}

class _ServiceScreenState extends State<ServiceScreen> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Services',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: getServicesContent(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return Container(
                margin: EdgeInsets.symmetric(
                    horizontal: ResponsiveFlutter.of(context).wp(2.0)),
                child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    ServicePageModel servicePageModel =
                        ServicePageModel.fromJson(
                            snapshot.data.docs[index].data());
                    return Container(
                      child: TextButton(
                        style: TextButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                            ),
                            primary: Colors.white,
                            onSurface: Colors.white,
                            textStyle: TextStyle(color: Colors.black),
                            shadowColor: Colors.white,
                            backgroundColor: Colors.transparent),
                        onPressed: () {
                          isSelected = true;
                          setState(() {});
                          isSelected = false;
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ServiceDetailsScreen(
                                  servicePageModel: servicePageModel,
                                ),
                              ));
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              color: isSelected
                                  ? themeColorYellow
                                  : Color(0xfffcfbf7),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveFlutter.of(context).wp(0.0),
                              vertical: ResponsiveFlutter.of(context).hp(2.5)),
                          width: double.infinity,
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    ResponsiveFlutter.of(context).wp(5.0)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  child: CachedNetworkImage(
                                    imageUrl: isSelected
                                        ? servicePageModel.small_icon_white
                                        : servicePageModel.small_icon,
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: imageProvider,
                                            fit: BoxFit.cover,
                                            scale: 3),
                                      ),
                                    ),
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal:
                                            ResponsiveFlutter.of(context)
                                                .wp(5.0)),
                                    child: Text(
                                      servicePageModel.title,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: TextStyle(
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2),
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                                Container(
                                  child: Image.asset(
                                    isSelected
                                        ? 'assets/images/next-white.png'
                                        : 'assets/images/next-yellow.png',
                                    scale: 3,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
