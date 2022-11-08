import 'package:cached_network_image/cached_network_image.dart';
import 'package:consulting1925/Model/projects-model.dart';
import 'package:consulting1925/services/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

import 'confirm-payment-screen.dart';

class ProjectDetailsScreen extends StatefulWidget {
  final ProjectModel projectModel;
  final String projectId;

  ProjectDetailsScreen({this.projectModel, this.projectId});

  @override
  _ProjectDetailsScreenState createState() =>
      _ProjectDetailsScreenState(this.projectModel);
}

class _ProjectDetailsScreenState extends State<ProjectDetailsScreen> {
  double paid = 0.0;
  double due = 0.0;

  ProjectModel projectModel;

  _ProjectDetailsScreenState(this.projectModel);

  @override
  void initState() {
    // TODO: implement initState

    updatePayment();

    super.initState();
  }

  updatePayment() {
    double totalAmt = double.parse(projectModel.total_charge);
    double dueAmt = double.parse(projectModel.balance_due);
    double paidAmt = double.parse(projectModel.balance_paid);

    due = (dueAmt * 100) / totalAmt;
    paid = (paidAmt * 100) / totalAmt;

    if (paid < 0 || due < 0) {
      paid = 0;
      due = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: Image.asset(
            "assets/images/back_ic.png",
            height: 25,
            width: 25,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: LayoutBuilder(
        builder: (context, constraint) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height / 2.2,
                          child: CachedNetworkImage(
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
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment(0, 1),
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black.withOpacity(0.7)
                              ], // red to yellow
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveFlutter.of(context).wp(5.0),
                              vertical: ResponsiveFlutter.of(context).wp(6.0)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Text(
                                      projectModel.project_name.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2.5),
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  Container(
                                    child: Text(
                                      getFormattedDate(projectModel.create_on),
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 10.0),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  /*  Container(
                                child: Text('Project Status'),
                              ),*/
                                  Container(
                                    child: new CircularPercentIndicator(
                                      radius: 40.0,
                                      lineWidth: 4.0,
                                      animation: true,
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      percent: (double.parse(widget
                                              .projectModel.project_status) /
                                          100),
                                      header: new Text(
                                        "Project Status",
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.white),
                                      ),
                                      center: new Text(
                                        projectModel.project_status.toString() +
                                            '%',
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            color: Colors.white),
                                      ),
                                      backgroundColor: Colors.grey,
                                      progressColor: Colors.amber,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      margin: EdgeInsets.only(
                        left: ResponsiveFlutter.of(context).wp(3.5),
                        right: ResponsiveFlutter.of(context).wp(3.5),
                      ),
                      child: Column(
                        children: [
                          Flexible(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      /* decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      ResponsiveFlutter.of(context)
                                          .verticalScale(100))),
                                ),
                                color: themeColorYellow),
                            height: ResponsiveFlutter.of(context).hp(3),
                            width: ResponsiveFlutter.of(context).wp(5),*/
                                      child: Icon(
                                        Icons.circle,
                                        color: themeColorYellow,
                                        size: 18.0,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal:
                                            ResponsiveFlutter.of(context)
                                                .wp(1.5),
                                      ),
                                      child: Text(
                                        'Starting Date',
                                        style: TextStyle(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2.0),
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal:
                                            ResponsiveFlutter.of(context)
                                                .wp(1.5),
                                      ),
                                      child: Text(
                                        format(widget.projectModel.start_date),
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      /*decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(
                                      ResponsiveFlutter.of(context)
                                          .verticalScale(100))),
                                ),
                                color: themeColorYellow),*/
                                      child: Icon(
                                        Icons.circle,
                                        color: themeColorYellow,
                                        size: 18.0,
                                      ),

                                      // height: ResponsiveFlutter.of(context).hp(3),
                                      // width: ResponsiveFlutter.of(context).wp(5),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal:
                                            ResponsiveFlutter.of(context)
                                                .wp(1.5),
                                      ),
                                      child: Text(
                                        'Ending Date',
                                        style: TextStyle(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2.0),
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal:
                                            ResponsiveFlutter.of(context)
                                                .wp(1.5),
                                      ),
                                      child: Text(
                                        format(widget.projectModel.end_date),
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Container(
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Colors.green,
                                        size: 17.0,
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal:
                                            ResponsiveFlutter.of(context)
                                                .wp(1.5),
                                      ),
                                      child: Text(
                                        'Estimated Completion Date',
                                        style: TextStyle(
                                          fontSize:
                                              ResponsiveFlutter.of(context)
                                                  .fontSize(2.0),
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                          horizontal:
                                              ResponsiveFlutter.of(context)
                                                  .wp(1.5),
                                        ),
                                        child: Text(
                                          format(widget.projectModel
                                              .estimate_completion_date),
                                          style: TextStyle(color: Colors.grey),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                horizontal:
                                    ResponsiveFlutter.of(context).wp(1.5),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Balance Paid:',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      new LinearPercentIndicator(
                                        padding: EdgeInsets.only(left: 4.0),
                                        width: 170.0,
                                        animation: true,
                                        animationDuration: 1000,
                                        lineHeight: 6.0,
                                        trailing: Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: new Text(
                                            (paid).floor().toString() + "%",
                                            style: TextStyle(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(1.9),
                                            ),
                                          ),
                                        ),
                                        percent: paid / 100,
                                        clipLinearGradient: true,
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: Colors.green,
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.4),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Balance Due:',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      new LinearPercentIndicator(
                                        padding: EdgeInsets.only(left: 4.0),
                                        width: 170.0,
                                        animation: true,
                                        animationDuration: 1000,
                                        lineHeight: 6.0,
                                        trailing: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: new Text(
                                            (due).ceil().toString() + "%",
                                            style: TextStyle(
                                              fontSize:
                                                  ResponsiveFlutter.of(context)
                                                      .fontSize(1.9),
                                            ),
                                          ),
                                        ),
                                        percent: due / 100,
                                        clipLinearGradient: true,
                                        linearStrokeCap:
                                            LinearStrokeCap.roundAll,
                                        progressColor: Colors.red,
                                        backgroundColor:
                                            Colors.grey.withOpacity(0.4),
                                      ),
                                    ],
                                  ),
                                  double.parse(widget.projectModel.balance_paid
                                                  .toString())
                                              .toInt() >=
                                          double.parse(widget
                                                  .projectModel.total_charge
                                                  .toString())
                                              .toInt()
                                      ? Container()
                                      : Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical:
                                                  ResponsiveFlutter.of(context)
                                                      .hp(5.0)),
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(5.0),
                                                  ),
                                                ),
                                                padding: EdgeInsets.symmetric(
                                                    vertical:
                                                        ResponsiveFlutter.of(
                                                                context)
                                                            .hp(2.0))),
                                            onPressed: () async {
                                              var model = await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ConfirmPaymentScreen(
                                                      projectModel:
                                                          projectModel,
                                                      projectId:
                                                          widget.projectId,
                                                    ),
                                                  ));
                                              projectModel = model != null
                                                  ? model
                                                  : projectModel;

                                              updatePayment();
                                              setState(() {});
                                            },
                                            child: Text(
                                              'Make Payment',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String getFormattedDate(DateTime date) {
    // 'Sep 12, 2019',

    if (date != null) {
      String formattedDate = DateFormat('MMM dd yyyy').format(date);
      return formattedDate;
    } else {
      return "";
    }
  }

  String getFormattedDate1(DateTime date) {
    // 21st April 2021',

    if (date != null) {
      String formattedDate = DateFormat('MMM dd yyyy').format(date);
      return formattedDate;
    } else {
      return "";
    }
  }

  format(DateTime date) {
    var suffix = "th";
    var digit = date.day % 10;
    if ((digit > 0 && digit < 4) && (date.day < 11 || date.day > 13)) {
      suffix = ["st", "nd", "rd"][digit - 1];
    }
    return new DateFormat("d'$suffix' MMMM yyyy").format(date);
  }

  String getConvertedPercentage(String purcentage) {
    return "";
  }
}
