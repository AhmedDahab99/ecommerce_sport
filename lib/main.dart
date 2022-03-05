import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:ecommerce_sport/UI/LandingPage.dart';
import 'package:ecommerce_sport/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sport E-Commerce',
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        duration: 1000,
        splash: Icon(
          Icons.shop,
          color: Colors.white,
          size: 100.0,
        ),
        nextScreen: LandingPage(),
        splashTransition: SplashTransition.scaleTransition,
        pageTransitionType: PageTransitionType.scale,
        backgroundColor: Color(0xff000221),
      ),
      theme: ThemeData(
//        primaryColor: Colors.black,
        scaffoldBackgroundColor: Color(0xffe2e0e2),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
        accentColor: Color(0xff000221)
      ),
    );
  }
}
