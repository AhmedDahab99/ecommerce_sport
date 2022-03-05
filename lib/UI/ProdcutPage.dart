import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_sport/Network/FirebaseServices.dart';
import 'package:ecommerce_sport/Widgets/CustomActionBar.dart';
import 'package:ecommerce_sport/Widgets/ImageSwipe.dart';
import 'package:ecommerce_sport/Widgets/ProductSize.dart';
import 'package:ecommerce_sport/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  final String productID;
  ProductPage({this.productID});
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  FirebaseServices _firebaseServices = FirebaseServices();



  String _selectedProductSize = "0";
//  String _selectedProductName = "Product Name";

  // Add to Cart Method
  Future _addToCart() {
    return _firebaseServices.usersReference
        .doc(_firebaseServices.getUserID())
        .collection("Cart")
        .doc(widget.productID)
        .set({
              "size": _selectedProductSize,
        });
  }
  Future _addToSaved() {
    return _firebaseServices.usersReference
        .doc(_firebaseServices.getUserID())
        .collection("Saved")
        .doc(widget.productID)
        .set({
      "size": _selectedProductSize,
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        FutureBuilder(
          future: _firebaseServices.productReference.doc(widget.productID).get(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Scaffold(
                body: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text(
                      "Error:${snapshot.error}",
                      style: Constants.regularHeading,
                    ),
                  ),
                ),
              );
            }

            if (snapshot.connectionState == ConnectionState.done) {
              // Map of Document Data
              Map<String, dynamic> docsData = snapshot.data.data();

              // List of Images
              List imageList = docsData["image"];
              List sizeList = docsData["size"];

              // set an initial size
              _selectedProductSize = sizeList[0];
              return ListView(
                padding: EdgeInsets.only(top: 25),
                children: [
                  ImageSwipe(
                    imageList: imageList,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 24, left: 16, right: 16, bottom: 0),
                    child: Text(
                      "${docsData["name"]}" ?? "Product Name",
                      style: Constants.semiBoldHeading,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                    child: Text(
                      "${docsData["price"]} \$" ?? "Product Price",
                      style: TextStyle(
                          fontSize: 24,
                          color: Color(0xffff0000),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                    child: Text(
                      "${docsData["desc"]}" ?? "Product Description",
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff000000).withOpacity(0.6)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 16, left: 16, right: 16, bottom: 4),
                    child:
                        Text("Select Size", style: Constants.semiBoldHeading),
                  ),
                  ProductSize(
                    sizeList: sizeList,
                    onSelected: (size){
                      _selectedProductSize = size;
                    },
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(top: 24, left: 2, right: 2, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            await _addToSaved();
                            // show FlushBar After add product to the cart
                            Flushbar(
                              padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                              margin: EdgeInsets.only(bottom: 15.0,left: 20,right: 20),
                              borderRadius: 20,
                              backgroundGradient: LinearGradient(

                                colors: [Color(0xffffffff),Color(0xff000221)],
                                stops: [0.3,1],
                              ),
                              boxShadows: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.6),
                                    offset: Offset(1, 3),
                                    blurRadius: 10,
                                    spreadRadius: 5
                                ),
                              ],
                              duration: Duration(seconds: 2),
                              forwardAnimationCurve: Curves.easeOutCirc,
                              messageText: Row(
                                children: [
                                  Text('Product Added To ',style:TextStyle(
                                    color: Color(0xff000221),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  Text('Your Saved List',style:TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                  ),),
                                ],
                              ),
                            )..show(context);

                          },
                          child: Container(
                            height: 50,
                            width: 60,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 5,
                                      spreadRadius: 1)
                                ]),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.bookmark_border_rounded,
                              size: 30,
                              color: Color(0xff000221),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () async{
                            await _addToCart();
                          // show FlushBar After add product to the cart
                            Flushbar(
                              padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 20),
                              margin: EdgeInsets.only(bottom: 15.0,left: 20,right: 20),
                              borderRadius: 20,
                              backgroundGradient: LinearGradient(
//                                begin: Alignment.topLeft,
//                                end: Alignment.bottomRight,
                                colors: [Color(0xff000221),Color(0xffffffff)],
                                stops: [0.3,1],
                              ),
                              boxShadows: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.6),
                                  offset: Offset(1, 3),
                                  blurRadius: 10,
                                  spreadRadius: 5
                                ),
                              ],
                              duration: Duration(seconds: 2),
                              forwardAnimationCurve: Curves.easeOutCirc,
                              messageText: Row(
                                children: [
                                  Text('Product Added To ',style:TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),),
                                  Text('Your Cart',style:TextStyle(
                                    color: Color(0xff000221),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w900,
                                  ),),
                                ],
                              ),
                            )..show(context);
                            //Scaffold.of(context).showSnackBar(_snackBar);
                          },
                          child: Container(
                            height: 50,
                            width: 265,
                            decoration: BoxDecoration(
                                color: Constants.darkBtnColor,
                                borderRadius: BorderRadius.circular(10.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black.withOpacity(0.2),
                                      blurRadius: 5,
                                      spreadRadius: 1)
                                ]),
                            alignment: Alignment.center,
                            child: Text(
                              "Add To Cart",
                              style: Constants.lightBoldHeading,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }

            //Loading State
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(
                      backgroundColor: Colors.white,
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      "Loading Product....",
                      style: Constants.darkBoldHeading,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        CustomActionBar(
          hasTitle: false,
          hasArrowBack: true,
          hasBackground: false,
        )
      ],
    ));
  }
}
