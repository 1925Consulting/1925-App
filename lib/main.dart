import 'package:consulting1925/screen/splash-screen.dart';
import 'package:consulting1925/services/global.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Stripe.publishableKey =
  //     'pk_test_51Ixv2IHOi1f8iczvLjSbFrDiJ7J7PiGTlWgoGBGlsZFlVwlujZrTJQu5oWox54rkQ2NizZ2pLDO1bdZ9szPh0ETe00r5KbkFJP';
  // Stripe.init(
  //     'pk_test_51Ixv2IHOi1f8iczvLjSbFrDiJ7J7PiGTlWgoGBGlsZFlVwlujZrTJQu5oWox54rkQ2NizZ2pLDO1bdZ9szPh0ETe00r5KbkFJP',
  //     returnUrlForSca: '');

  // await StripePaymentInitialize().init();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

const MaterialColor kPrimaryColor = const MaterialColor(
  0xffCEA972,
  const <int, Color>{
    50: const Color(0xffCEA972),
    100: const Color(0xffCEA972),
    200: const Color(0xffCEA972),
    300: const Color(0xffCEA972),
    400: const Color(0xffCEA972),
    500: const Color(0xffCEA972),
    600: const Color(0xffCEA972),
    700: const Color(0xffCEA972),
    800: const Color(0xffCEA972),
    900: const Color(0xffCEA972),
  },
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: "Poppins",
          appBarTheme: AppBarTheme(
            color: Colors.transparent,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.black),
            textTheme: TextTheme(
              caption: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
          ),
          hintColor: Colors.black54,
          scaffoldBackgroundColor: themeColorYellow.withOpacity(0.8),
          primarySwatch: kPrimaryColor,
          textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)))),
            backgroundColor: MaterialStateProperty.all<Color>(themeColorYellow),
            textStyle: MaterialStateProperty.all<TextStyle>(
              TextStyle(color: Colors.white, fontFamily: 'Poppins'),
            ),
          ))),
      home: SplashScreen(),
    );
  }
}
