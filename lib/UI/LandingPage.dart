import 'package:ecommerce_sport/UI/HomePage.dart';
import 'package:ecommerce_sport/UI/LoginPage.dart';
import 'package:ecommerce_sport/Widgets/CustomBottomTabs.dart';
import 'package:ecommerce_sport/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  final Future<FirebaseApp> initializeApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: initializeApp,
        builder: (context, snapshot) {
          // if snapshot has error
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error:${snapshot.error}"),
              ),
            );
          }
          // connection initialized || Firebase App is running
          if (snapshot.connectionState == ConnectionState.done) {
            // This Stream Builder check Login State live!
            return StreamBuilder(
                stream: FirebaseAuth.instance.authStateChanges(),
                builder: (context , streamSnapshot){
                  // if snapshot has error
                  if (snapshot.hasError) {
                    return Scaffold(
                      body: Center(
                        child: Text("Error:${streamSnapshot.error}"),
                      ),
                    );
                  }
                  //Connection State active  - Do the user login check in IF statement
                  if(streamSnapshot.connectionState == ConnectionState.active){
                    // Get the User
                    User _user=streamSnapshot.data;
                    // if the user is null , we're not logged in
                    if(_user == null){
                      // if the user is null , go to LoginPage
                        return LoginPage();
                    }
                    else{
                      // the user is logged in, go to HomePage
                      return HomePage();
                    }
                  }
                  return Scaffold(
                    body: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(height: 15.0,),
                          Text("Checking Authentication....",style: Constants.regularHeading,),
                        ],
                      ),
                    ),
                  );
                }
            );
          }
          // connection initializing.....
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(height: 15.0,),
                  Text("Checking Firebase Connection....",style: Constants.regularHeading,),
                ],
              ),
            ),
          );
        });
  }
}
