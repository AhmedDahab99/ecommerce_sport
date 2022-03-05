import 'package:flutter/material.dart';

import '../constants.dart';

class ProductSize extends StatefulWidget {
  final List sizeList;
  final Function(String) onSelected;
  ProductSize({this.sizeList, this.onSelected});
  @override
  _ProductSizeState createState() => _ProductSizeState();
}

class _ProductSizeState extends State<ProductSize> {
  int _selectedSize=0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(left:10.0),
      child: Row(
        children: [
          for (var sizeIndex = 0; sizeIndex < widget.sizeList.length; sizeIndex++)
            GestureDetector(
              onTap: (){
                widget.onSelected("${widget.sizeList[sizeIndex]}");
                setState(() {
                  _selectedSize = sizeIndex;
                });
              },
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 6.0),
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _selectedSize == sizeIndex?Color(0xff000221):Colors.white,
                  borderRadius: BorderRadius.circular(10.0)
                ),
                alignment: Alignment.center,
                child: Text("${widget.sizeList[sizeIndex]}" ?? "Select Size",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                      color: _selectedSize == sizeIndex?Colors.white:Color(0xff000221)
                    )),
              ),
            )
        ],
      ),
    );
  }
}
