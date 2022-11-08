import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:consulting1925/Model/our-project-screen-model.dart';
import 'package:consulting1925/services/firebase.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OurProjectScreen extends StatefulWidget {
  @override
  _OurProjectScreenState createState() => _OurProjectScreenState();
}

class _OurProjectScreenState extends State<OurProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Our Projects',
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
          stream: getProjectsContent(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  OurProjectScreenModel ourProjectScreenModel =
                      OurProjectScreenModel.fromJson(
                          snapshot.data.docs[index].data());

                  return InkResponse(
                    onTap: () => _launchURL(ourProjectScreenModel.link),
                    child: Container(
                      margin: EdgeInsets.all(10),
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            child: Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.width / 3,
                              child: Image.network(
                                ourProjectScreenModel.image_url,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(top: 5),
                            child: Text(
                              ourProjectScreenModel.name,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
