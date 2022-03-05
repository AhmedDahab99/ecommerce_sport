import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_sport/Network/FirebaseServices.dart';
import 'package:ecommerce_sport/UI/ProdcutPage.dart';
import 'package:ecommerce_sport/Widgets/CustomInputField.dart';
import 'package:ecommerce_sport/Widgets/ProductCard.dart';
import 'package:ecommerce_sport/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchTap extends StatefulWidget {
  @override
  _SearchTapState createState() => _SearchTapState();
}

class _SearchTapState extends State<SearchTap> {
  FirebaseServices _firebaseServices = FirebaseServices();
  String _searchString = "";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          if (_searchString.isEmpty)
            Center(
              child: Container(
                  child: Text(
                "Search Results . . .",
                style: Constants.regularDarkText,
              )),
            )
          else
            FutureBuilder<QuerySnapshot>(
                future: _firebaseServices.productReference
                    .orderBy("name")
                    .startAt([_searchString]).endAt(
                        ["$_searchString\uf8ff"]).get(),
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
                  // display products is ready
                  if (snapshot.connectionState == ConnectionState.done) {
                    // Display the products in list view
                    return GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1),
                      padding: EdgeInsets.only(top: 140, bottom: 25),
                      children: snapshot.data.docs.map((document) {
                        return ProductCard(
                          title: document.data()["name"],
                          imageUrl: document.data()["image"][0],
                          price: "${document.data()["price"]}\$",
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductPage(
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
                          SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            "Loading Products....",
                            style: Constants.darkBoldHeading,
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 45),
                child: CustomInputField(
                  hintText: "Search About Product . . .",
                  obscureText: false,
                  prefixIcon: Icon(Icons.search_rounded),
                  onSubmit: (value) {
                      setState(() {
                        _searchString = value;
                      });
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

//Column(
//children: [
//SizedBox(height: MediaQuery.of(context).size.height*0.06,),
//CustomInputField(
//hintText: "Search About Product . . .",
//obscureText: false,
//prefixIcon: Icon(Icons.search_rounded),
//onSubmit: (value){
//if(value.isNotEmpty){
//
//}
//},
//),
//Text("Search Results . . .",style: Constants.regularDarkText,),
//],
//)
