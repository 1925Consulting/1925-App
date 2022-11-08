import 'package:consulting1925/Model/projects-model.dart';
import 'package:consulting1925/services/global.dart';
import 'package:consulting1925/services/stripe-payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:keyboard_dismisser/keyboard_dismisser.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:responsive_flutter/responsive_flutter.dart';

class CardDetails extends StatefulWidget {
  final int amount;
  final ProjectModel projectModel;

  const CardDetails({Key key, this.amount, this.projectModel})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CardDetailsState();
  }
}

class CardDetailsState extends State<CardDetails> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return KeyboardDismisser(
      gestures: [
        GestureType.onPanDown,
        GestureType.onPanStart,
        GestureType.onTap,
        // GestureType.onPanUpdateDownDirection,
      ],
      child: ModalProgressHUD(
        inAsyncCall: isLoading,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text(
              'Card Details',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w500,
                  fontSize: 20),
            ),
          ),
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Column(
              children: <Widget>[
                CreditCardWidget(
                  cardNumber: cardNumber,
                  expiryDate: expiryDate,
                  cardHolderName: cardHolderName,
                  cvvCode: cvvCode,
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                  cardBgColor: themeColorYellow,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        CreditCardForm(
                          formKey: formKey,
                          obscureCvv: true,
                          obscureNumber: true,
                          cardNumber: cardNumber,
                          cvvCode: cvvCode,
                          cardHolderName: cardHolderName,
                          expiryDate: expiryDate,
                          cvvValidationMessage: 'Invalid CVV',
                          dateValidationMessage: 'Invalid Date',
                          themeColor: themeColorYellow,
                          cardNumberDecoration: const InputDecoration(
                            labelText: 'Number',
                            hintText: 'XXXX XXXX XXXX XXXX',
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(color: Color(0xffCEA972)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(color: Color(0xffCEA972)),
                            ),
                            labelStyle: TextStyle(color: Color(0xffCEA972)),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide:
                                    BorderSide(color: Color(0xFFefefef))),
                          ),
                          expiryDateDecoration: const InputDecoration(
                              labelText: 'Expired Date',
                              focusColor: Color(0xffCEA972),
                              hintText: 'XX/XX',
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide:
                                    BorderSide(color: Color(0xffCEA972)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide:
                                    BorderSide(color: Color(0xffCEA972)),
                              ),
                              labelStyle: TextStyle(color: Color(0xffCEA972)),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                                borderSide:
                                    BorderSide(color: Color(0xFFefefef)),
                              )),
                          cvvCodeDecoration: InputDecoration(
                            hoverColor: Color(0xffCEA972),
                            focusColor: Color(0xffCEA972),
                            fillColor: Color(0xffCEA972),
                            labelStyle: TextStyle(color: Color(0xffCEA972)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(color: Color(0xffCEA972)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(color: Color(0xffCEA972)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(color: Color(0xFFefefef)),
                            ),
                            labelText: 'CVV',
                            hintText: 'XXX',
                          ),
                          cardHolderDecoration: InputDecoration(
                            labelStyle: TextStyle(color: Color(0xffCEA972)),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(color: Color(0xffCEA972)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(color: Color(0xffCEA972)),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(10.0),
                              ),
                              borderSide: BorderSide(color: Color(0xFFefefef)),
                            ),
                            focusColor: Color(0xffCEA972),
                            labelText: 'Card Holder (Optional)',
                          ),
                          onCreditCardModelChange: onCreditCardModelChange,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: ResponsiveFlutter.of(context).hp(5.0),
                              horizontal:
                                  ResponsiveFlutter.of(context).hp(2.0)),
                          width: MediaQuery.of(context).size.width,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: ResponsiveFlutter.of(context).hp(1.5),
                              ),
                            ),
                            onPressed: () async {
                              FocusScope.of(context).requestFocus(FocusNode());

                              if (formKey.currentState.validate()) {
                                print('valid!');
                                setState(() {
                                  isLoading = true;
                                });
                                var payment = await StripePaymentInitialize()
                                    .requestCardPayment(
                                        cardNumber,
                                        int.parse(expiryDate
                                            .split('/')
                                            .first
                                            .toString()),
                                        int.parse(expiryDate
                                            .split('/')
                                            .last
                                            .toString()),
                                        widget.amount,
                                        widget.projectModel,
                                        cvvCode);
                                if (payment == null) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  buildErrorDialog(
                                      context, 'Error', 'Something went Wrong');
                                } else if (payment['id'] == null) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  buildErrorDialog(context, 'Error',
                                      payment['error']['message']);
                                } else {
                                  Navigator.pop(context, true);
                                  /*setState(() {
                                        isLoading = false;
                                      });*/
                                  /* buildErrorDialog(
                                          context, '', 'Payment Successfully done');*/
                                }
                                print(payment);
                                /* print(payment);
                                      print(payment.status);*/
                              } else {
                                // setState(() {
                                //   isLoading = false;
                                // });
                                print('invalid!');
                              }
                            },
                            child: Text(
                              'Pay \$${widget.amount / 100}',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
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
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}
