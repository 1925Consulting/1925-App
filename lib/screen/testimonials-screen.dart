import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consulting1925/Model/testimonials-page-model.dart';
import 'package:consulting1925/services/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class TestimonialsScreen extends StatefulWidget {
  @override
  _TestimonialsScreenState createState() => _TestimonialsScreenState();
}

class _TestimonialsScreenState extends State<TestimonialsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Testimonials',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
        ),
        // leading: GestureDetector(
        //   child: Container(
        //     child: Image.asset("assets/images/back.png"),
        //   ),
        //   onTap: () {
        //     Navigator.pop(context);
        //   },
        // ),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: getTestimonialsContent(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    TestimonialsPageModel testimonialsPageModel =
                        TestimonialsPageModel.fromJson(
                            snapshot.data.docs[index].data());
                    return Container(
                      margin: EdgeInsets.symmetric(
                        horizontal: ResponsiveFlutter.of(context).wp(5.0),
                        vertical: ResponsiveFlutter.of(context).wp(4.0),
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xffffcfbf7),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        /* boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],*/
                      ),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                Text(
                                  testimonialsPageModel.written_by.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16),
                                ),
                                Spacer(),
                                Text(
                                  getFormattedDate(testimonialsPageModel),
                                  style: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: 45,
                            child: Align(
                              //Put rating view here
                              alignment: Alignment.centerLeft,
                              child: RatingBarIndicator(
                                rating: testimonialsPageModel.rating,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star_rate_rounded,
                                  color: Color(0xfff6cc5c),
                                ),
                                itemCount: 5,
                                itemSize: 25.0,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              testimonialsPageModel.text
                                  .toString()
                                  .replaceAll("\\n", "\n"),
                              style: TextStyle(
                                  color: Colors.black45,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14),
                            ),
                          ),
                        ],
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

  String getFormattedDate(TestimonialsPageModel testimonialsPageModel) {
    if (testimonialsPageModel != null && testimonialsPageModel.date != null) {
      String formattedDate =
          DateFormat('dd MMM yyyy').format(testimonialsPageModel.date);
      return formattedDate;
    } else {
      return "";
    }
  }
}
