import 'package:consulting1925/screen/about-us-screen.dart';
import 'package:consulting1925/screen/client-side/log-in-screen.dart';
import 'package:consulting1925/screen/client-side/project-screen.dart';
import 'package:consulting1925/screen/our-project-screen.dart';
import 'package:consulting1925/screen/services-screen.dart';
import 'package:consulting1925/screen/testimonials-screen.dart';
import 'package:consulting1925/services/global.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';

int SelectedIndex = 2;

class DashboardNavigation extends StatefulWidget {
  @override
  _DashboardNavigationState createState() => _DashboardNavigationState();
}

class _DashboardNavigationState extends State<DashboardNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SelectedIndex == 0
            ? AboutUsScreen()
            : SelectedIndex == 1
                ? TestimonialsScreen()
                : SelectedIndex == 2
                    ? ServiceScreen()
                    : SelectedIndex == 3
                        ? OurProjectScreen()
                        : SelectedIndex == 4 && user != null
                            ? ProjectScreen()
                            : ClientLoginScreen(),
        bottomNavigationBar: ConvexAppBar(
          color: themeColorGrey,
          backgroundColor: themeColorGrey,
          curveSize: 0,
          activeColor: themeColorGrey, //Colors.black.withOpacity(0.2),
          items: [
            TabItem(
              activeIcon: getActiveIconForNavigation(0),
              icon: getIconForNavigation(0),
            ),
            TabItem(
              activeIcon: getActiveIconForNavigation(1),
              icon: getIconForNavigation(1),
            ),
            TabItem(
              activeIcon: getActiveIconForNavigation(2),
              icon: getIconForNavigation(2),
            ),
            TabItem(
              activeIcon: getActiveIconForNavigation(3),
              icon: getIconForNavigation(3),
            ),
            TabItem(
              activeIcon: getActiveIconForNavigation(4),
              icon: getIconForNavigation(4),
            ),
          ],
          initialActiveIndex: SelectedIndex, //optional, default as 0
          onTap: (int i) {
            SelectedIndex = i;
            setState(() {});
          },
        ));
  }

  Widget getIconForNavigation(int index) {
    String tabImage = "";
    if (index == 0) {
      tabImage = "logo.png";
    } else if (index == 1) {
      tabImage = "review.png";
    } else if (index == 2) {
      tabImage = "briefcase.png";
    } else if (index == 3) {
      tabImage = "layer.png";
    } else if (index == 4) {
      tabImage = "user.png";
    } else {
      tabImage = "lion.png";
    }

    return Image.asset(
      "assets/images/" + tabImage,
      height: 25,
      width: 25,
    );
  }

  Widget getActiveIconForNavigation(int index) {
    String tabImage = "";
    if (index == 0) {
      tabImage = "logo-selected.png";
    } else if (index == 1) {
      tabImage = "review-selected.png";
    } else if (index == 2) {
      tabImage = "briefcase-selected.png";
    } else if (index == 3) {
      tabImage = "layer-selected.png";
    } else if (index == 4) {
      tabImage = "user-selected.png";
    } else {
      tabImage = "lion.png";
    }

    return Image.asset(
      "assets/images/" + tabImage,
      height: 25,
      width: 25,
    );
  }
}
