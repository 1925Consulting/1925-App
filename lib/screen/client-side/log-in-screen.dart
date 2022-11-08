import 'package:consulting1925/screen/client-side/forgot-password.dart';
import 'package:consulting1925/screen/navigation-bar-screen.dart';
import 'package:consulting1925/services/global.dart';
import 'package:consulting1925/services/shared-preferance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:responsive_flutter/responsive_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class ClientLoginScreen extends StatefulWidget {
  @override
  _ClientLoginScreenState createState() => _ClientLoginScreenState();
}

class _ClientLoginScreenState extends State<ClientLoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool IsPasswordShow = true;
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: ResponsiveFlutter.of(context).wp(10.0),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/images/logo-black.png",
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 30),
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black),
                        )),
                    Container(
                      margin: EdgeInsets.only(
                        bottom: ResponsiveFlutter.of(context).hp(4.0),
                      ),
                      width: double.infinity,
                      child: Text("Enter your email and password",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.black54)),
                    ),
                    Container(
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Email';
                          } else if (!isValidEmail(
                              emailController.text.toString())) {
                            return 'Please enter valid Email';
                          }
                          return null;
                        },
                        controller: emailController,
                        maxLines: 1,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hoverColor: Color(0xFFefefef),
                          focusColor: Color(0xFFefefef),
                          fillColor: Color(0xFFefefef),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          prefixIcon: Container(
                            width: 80,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  "assets/images/email.png",
                                  scale: 1.4,
                                ),
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.centerRight,
                                    width: 1.0,
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                    ),
                                    height: 50,
                                  ),
                                )
                              ],
                            ),
                          ),
                          hintText: '',
                          hintStyle: TextStyle(
                            color: Colors.black54,
                          ),
                          labelText: 'Email',
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: ResponsiveFlutter.of(context).hp(1.5),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter Password';
                          }
                          return null;
                        },
                        controller: passwordController,
                        maxLines: 1,
                        obscureText: IsPasswordShow,
                        decoration: InputDecoration(
                            hoverColor: Color(0xFFefefef),
                            focusColor: Color(0xFFefefef),
                            fillColor: Color(0xFFefefef),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(color: Color(0xFFefefef)),
                            ),
                            prefixIcon: Container(
                              width: 80,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    "assets/images/password.png",
                                    scale: 1.4,
                                  ),
                                  Flexible(
                                    child: Container(
                                      alignment: Alignment.centerRight,
                                      width: 1.0,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                      ),
                                      height: 50,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            suffixIcon: GestureDetector(
                              child: Image.asset(!IsPasswordShow
                                  ? "assets/images/invisible.png"
                                  : "assets/images/eye.png"),
                              onTap: () {
                                IsPasswordShow = !IsPasswordShow;
                                setState(() {});
                              },
                            ),
                            hintText: '',
                            labelText: "Password"),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: GestureDetector(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            )),
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(color: themeColorYellow),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 25),
                      width: double.infinity,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: ResponsiveFlutter.of(context).hp(2.0),
                          ),
                        ),
                        onPressed: () {
                          if (_formKey.currentState.validate()) logIn();
                        },
                        child: Text(
                          'Sign In',
                          style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.symmetric(vertical: 25),
                        width: double.infinity,
                        child: privacyPolicyLinkAndTermsOfService()),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  logIn() async {
    setState(() {
      isLoading = true;
    });
    user = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.trim().toString(),
                password: passwordController.text.trim().toString())
            .catchError((onError) {
      setState(() {
        isLoading = false;
      });
      buildErrorDialog(context, 'Error', 'Email and Password not match');
    }))
        .user
        .uid;

    if (user != null) {
      await SaveDataLocal.saveUserData(user);
      SelectedIndex = 4;
      Navigator.pushReplacement(
          context,
          PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  DashboardNavigation(),
              transitionDuration: Duration(seconds: 0)));
      // Navigator.pop(context, true);
    } else {
      setState(() {
        isLoading = false;
      });
      buildErrorDialog(context, 'Error', 'Email and Password not match');
    }
  }

  Widget privacyPolicyLinkAndTermsOfService() {
    return Container(
      alignment: Alignment.center,
      child: Center(
          child: Text.rich(TextSpan(
              text: 'By continuing, you agree to our ',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
              ),
              children: <TextSpan>[
            TextSpan(
                text: 'Terms of Service',
                style: TextStyle(
                  fontSize: 16,
                  color: themeColorYellow,
                  decoration: TextDecoration.underline,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    _launchURL('https://1925consulting.com/privacy-policy');

                    // code to open / launch terms of service link here
                  }),
            TextSpan(
                text: ' and ',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                          fontSize: 16,
                          color: themeColorYellow,
                          decoration: TextDecoration.underline),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          _launchURL(
                              'https://1925consulting.com/privacy-policy');
                          // code to open / launch privacy policy link here
                        })
                ])
          ]))),
    );
  }

  void _launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';
}
