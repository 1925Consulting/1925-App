import 'dart:convert';
import 'dart:io';

import 'package:consulting1925/Model/projects-model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String clientSecret =
    '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';

class StripePaymentInitialize {
  init() {
    // Stripe.publishableKey =
    //     'pk_test_51Ixv2IHOi1f8iczvLjSbFrDiJ7J7PiGTlWgoGBGlsZFlVwlujZrTJQu5oWox54rkQ2NizZ2pLDO1bdZ9szPh0ETe00r5KbkFJP';
    // Stripe.init(
    //     'pk_test_51Ixv2IHOi1f8iczvLjSbFrDiJ7J7PiGTlWgoGBGlsZFlVwlujZrTJQu5oWox54rkQ2NizZ2pLDO1bdZ9szPh0ETe00r5KbkFJP',
    //     returnUrlForSca: 'stripesdk://3ds.stripesdk.io');

    // StripePayment.setOptions(StripeOptions(
    //     publishableKey:
    //         "pk_test_51Ixv2IHOi1f8iczvLjSbFrDiJ7J7PiGTlWgoGBGlsZFlVwlujZrTJQu5oWox54rkQ2NizZ2pLDO1bdZ9szPh0ETe00r5KbkFJP",
    //     merchantId: "test",
    //     androidPayMode: 'test'));
  }

  // Future<Source> makePayment(amount) async {
  //   _stripePayment.
  //   return await StripePayment.createSourceWithParams(SourceParams(
  //     type: 'giropay',
  //     amount: amount,
  //     country: 'US',
  //     statementDescriptor: '1925 Consulting',
  //     currency: 'usd',
  //     returnURL: 'consulting://stripe-redirect',
  //   )).catchError((setError) {
  //     print('Eroor' + setError.toString());
  //   });
  // }

  Future<Map<String, dynamic>> requestCardPayment(cardNUmber, int expMonth,
      int expYear, amount, ProjectModel projectModel, cvc) async {
    /*   final CreditCard testCard = CreditCard(
        number: cardNUmber,
        expMonth: expMonth,
        expYear: expYear,
        cvc: '123',
        last4: '4242',
        brand: 'VISA',
        addressLine1: 'surat',
        addressLine2: 'india');

    // PaymentMethod paymentMethod =
    //     await Stripe.instance.createPaymentMethod(PaymentMethodParams.card());
    // Map<String, dynamic> token = await Stripe.instance.api
    //     .createPaymentMethodFromCard(StripeCard(
    //         expYear: 25,
    //         expMonth: 1,
    //         cvc: '123',
    //         last4: '4242',
    //         number: '4242424242424242'));
    // //
    // Token token =
    //     await StripePayment.createTokenWithCard(testCard).catchError((onError) {
    //   print('Error ' + onError.toString());
    //   return null;
    // });

    // PaymentMethod paymentMethod = await StripePayment.createPaymentMethod(
    //     PaymentMethodRequest(card: testCard));
    Token token =
        await StripePayment.createTokenWithCard(testCard).catchError((onError) {
      print(onError.toString());
    });*/
    // var stripePaymentMethod = await StripePayment.createPaymentMethod(
    //     PaymentMethodRequest(card: testCard));

    print('called');
    Map<String, dynamic> map = Map();
    map['card[number]'] = cardNUmber;
    map['card[exp_month]'] = expMonth.toString();
    map['card[exp_year]'] = expYear.toString();
    map['card[cvc]'] = cvc.toString();
    // Map<String, Object> card = new HashMap<>();
    // card.put("number", "4242424242424242");
    // card.put("exp_month", 6);
    // card.put("exp_year", 2022);
    // card.put("cvc", "314");
    // Map<String, Object> params = new HashMap<>();
    // params.put("card", card);
    final response =
        await http.post(Uri.parse('https://api.stripe.com/v1/tokens'),
            headers: {
              'Authorization': 'Bearer  $clientSecret',
              'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: map);

    print(json.decode(response.body));

    if (response == null) {
      return null;
    } else {
      return await createCharge(
          json.decode(response.body)['id'], amount, projectModel);

      // return await createCharge(token.tokenId, amount, projectModel);
      // final clientSecret = await Stripe.instance.api.createToken(data)
      // .createPaymentIntent(Stripe.instance.getReturnUrlForSca());
      /* final paymentIntent = await Stripe.instance
          .confirmPayment(clientSecret, paymentMethodId: token['id']);*/
    }
  }

  static Future<Map<String, dynamic>> createCharge(
      String tokenId, amount, ProjectModel projectModel) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount.toString(),
        'currency': 'usd',
        'source': tokenId,
        'description': projectModel.project_name,
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/charges'),
          body: body,
          headers: {
            'Authorization': 'Bearer  $clientSecret',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
    return null;
  }
}

class StripeTransactionResponse {
  String message;
  bool success;

  StripeTransactionResponse({this.message, this.success});
}

class ShowDialogToDismiss extends StatelessWidget {
  final String content;
  final String title;
  final String buttonText;

  ShowDialogToDismiss({this.title, this.buttonText, this.content});

  @override
  Widget build(BuildContext context) {
    if (!Platform.isIOS) {
      return AlertDialog(
        title: new Text(
          title,
        ),
        content: new Text(
          this.content,
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text(
              buttonText,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    } else {
      return CupertinoAlertDialog(
          title: Text(
            title,
          ),
          content: new Text(
            this.content,
          ),
          actions: <Widget>[
            CupertinoDialogAction(
              isDefaultAction: true,
              child: new Text(
                buttonText[0].toUpperCase() +
                    buttonText.substring(1).toLowerCase(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ]);
    }
  }
}
