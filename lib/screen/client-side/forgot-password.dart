import 'package:consulting1925/services/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key key}) : super(key: key);

  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Forgot Password'),
          centerTitle: true,
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.symmetric(
            horizontal: ResponsiveFlutter.of(context).wp(5.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                  margin: EdgeInsets.only(
                    top: ResponsiveFlutter.of(context).hp(2.0),
                    bottom: ResponsiveFlutter.of(context).hp(2.0),
                  ),
                  child: Text('Enter Your Register Email Below')),
              Form(
                key: _formKey,
                child: Container(
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
                      hintText: '',
                      hintStyle: TextStyle(
                        color: Colors.black54,
                      ),
                      labelText: 'Email',
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(
                      vertical: ResponsiveFlutter.of(context).hp(2.0),
                    ),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(
                          ResponsiveFlutter.of(context).hp(2.0),
                        ),
                      ),
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            isLoading = true;
                          });
                          FirebaseAuth.instance
                              .sendPasswordResetEmail(
                                  email: emailController.text.trim().toString())
                              .then((value) {
                            if (isLoading) {
                              setState(() {
                                isLoading = false;
                              });
                            }
                            showInSnackBar('Email Sent Successfully');

                            Navigator.pop(context);
                          }).catchError((onError) {
                            if (isLoading) {
                              setState(() {
                                isLoading = false;
                              });
                            }
                            showInSnackBar('Email not Exits');
                            print(onError);
                          });
                        }
                      },
                      child: Text(
                        'Forgot Password',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text(value),
        backgroundColor: themeColorYellow,
      ),
    );
  }
}
