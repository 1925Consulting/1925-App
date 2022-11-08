import 'package:consulting1925/services/global.dart';
import 'package:flutter/material.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class PaymentMethodScreen extends StatefulWidget {
  @override
  _PaymentMethodScreenState createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  List<String> arrImage = ["Mastwrcard.png", "paypal.png", "visa.png"];
  List<String> arrName = ["Master Card", "PayPal", "Visa"];

  int selectedIndex = null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset('assets/images/back.png'),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Text("Payment method"),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 30),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: arrName.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      color: selectedIndex != null && selectedIndex == index
                          ? themeColorYellow
                          : Colors.white,
                    ),
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Row(
                      children: [
                        Container(
                          height: 30,
                          width: 30,
                          child:
                              Image.asset('assets/images/' + arrImage[index]),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 30),
                              child: Text(
                                arrName[index],
                                style: TextStyle(fontSize: 16),
                              )),
                        ),
                        selectedIndex != null && selectedIndex == index
                            ? Icon(
                                Icons.radio_button_checked,
                                color: Colors.white,
                                size: 30,
                              )
                            : Icon(
                                Icons.radio_button_off,
                                color: Colors.grey.withOpacity(0.7),
                                size: 30,
                              ),
                      ],
                    ),
                  ),
                  onTap: () {
                    selectedIndex = index;
                    setState(() {});
                  },
                );
              },
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.symmetric(
                vertical: ResponsiveFlutter.of(context).hp(5.0),
                horizontal: 20),
            width: MediaQuery.of(context).size.width,
            child: TextButton(
              style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(5.0),
                    ),
                  ),
                  padding: EdgeInsets.symmetric(
                      vertical: ResponsiveFlutter.of(context).hp(2.0))),
              onPressed: () {},
              child: Text(
                'Continue',
                style: TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
