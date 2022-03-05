import 'package:ecommerce_sport/UI/ProdcutPage.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {

  final String productID;
  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;
  ProductCard({this.onPressed, this.imageUrl, this.title, this.price, this.productID});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:GestureDetector(
          onTap: (){
            onPressed();
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                    blurRadius: 3,
                    spreadRadius: 1,
                    color: Colors.black.withOpacity(0.3)
                )
              ],
            ),
            height: 350,
            width: MediaQuery.of(context).size.width/1.1,
            margin: EdgeInsets.symmetric(horizontal: 24,vertical: 12),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.network(
                    "$imageUrl",
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom:0,
                  left:0,
                  right:0,
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(title,style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        )),
                        Text(price,style: TextStyle(
                            fontSize: 26,
                            color: Colors.yellowAccent,
                            fontWeight: FontWeight.w500
                        ),)
                      ],
                    ),
                    height: 60,
                    padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 6),
                    decoration: BoxDecoration(
                        color: Color(0xff000221).withOpacity(0.8),
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
    );
  }
}




