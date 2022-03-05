import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_sport/UI/ProdcutPage.dart';
import 'package:ecommerce_sport/Widgets/CustomActionBar.dart';
import 'package:ecommerce_sport/Widgets/ProductCard.dart';
import 'package:ecommerce_sport/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class HomeTap extends StatefulWidget {
  @override
  _HomeTapState createState() => _HomeTapState();
}

class _HomeTapState extends State<HomeTap> {

  final CollectionReference _productReference =
            FirebaseFirestore.instance.collection("Products");
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
              future: _productReference.get(),
              builder: (context , snapshot){
                if(snapshot.hasError){
                  return Scaffold(
                    body: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Text("Error:${snapshot.error}",style: Constants.regularHeading,),
                      ),
                    ),
                  );
                }
                // display products is ready
                if(snapshot.connectionState == ConnectionState.done){
                  // Display the products in list view
                  return GridView(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
                    padding: EdgeInsets.only(top:100,bottom: 25),
                    children: snapshot.data.docs.map((document){
                      return ProductCard(
                        title: document.data()["name"],
                        imageUrl: document.data()["image"][0],
                        price: "${document.data()["price"]}\$",
                        onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductPage(
                            productID: document.id,
                          )));
                        },
                      );
                    }).toList(),
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
                        SizedBox(height: 15.0,),
                        Text("Loading Products....",style: Constants.darkBoldHeading,),
                      ],
                    ),
                  ),
                );
              }
          ),
          CustomActionBar(
            title: "Home",
            hasTitle: true,
            hasArrowBack: false,
          )
        ],
      ),
    );
  }
}
