import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_sport/Network/FirebaseServices.dart';
import 'package:ecommerce_sport/UI/CartPage.dart';
import 'package:ecommerce_sport/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomActionBar extends StatelessWidget {
  final String title;
  final bool hasArrowBack;
  final bool hasTitle;
  final bool hasBackground;
  CustomActionBar(
      {this.title, this.hasArrowBack, this.hasTitle, this.hasBackground});

  final CollectionReference _usersReference = FirebaseFirestore.instance
      .collection("Users");

  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    bool _hasArrowBack = hasArrowBack ?? false;
    bool _hasTitle = hasTitle ?? false;
    bool _hasBackground = hasBackground ?? true;

    return Container(
      decoration: BoxDecoration(
          gradient: _hasBackground
              ? LinearGradient(
                  begin: Alignment(1, 1),
                  end: Alignment(0, 1),
                  colors: [
                      Color(0xffffffff),
                      Color(0xffffffff).withOpacity(0.1)
                    ])
              : null,
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(12.0),
              bottomLeft: Radius.circular(12.0))),
      padding: EdgeInsets.only(top: 40, left: 24, right: 24, bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_hasArrowBack)
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Card(
                  elevation: 10,
                  color: Colors.redAccent[700],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 18.0, right: 12.0, top: 12, bottom: 12),
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.white,
                    ),
                  )),
            ),
          if (_hasTitle)
            Text(
              title,
              style: Constants.darkBoldHeading,
            ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>CartPage()));
            },
            child: Card(
                elevation: 10,
                color: Color(0xff000221),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                child: Padding(
                  padding:
                      EdgeInsets.only(left: 18.0, right: 18.0, top: 8, bottom: 8),
                  child: StreamBuilder(
                    stream: _usersReference.doc(_firebaseServices.getUserID()).collection("Cart").snapshots(),
                    builder: (context , snapshot){
                      int totalProducts = 0;

                      if(snapshot.connectionState == ConnectionState.active){
                        List _documents = snapshot.data.docs;
                        totalProducts = _documents.length;
                      }

                      return Text(
                        "$totalProducts"??"0",
                        style: Constants.lightBoldHeading,
                      );
                    },
                  )
                )),
          ),
        ],
      ),
    );
  }
}
