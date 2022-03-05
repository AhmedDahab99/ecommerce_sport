import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ImageSwipe extends StatefulWidget {
  final List imageList;
  const ImageSwipe({this.imageList});
  @override
  _ImageSwipeState createState() => _ImageSwipeState();
}

class _ImageSwipeState extends State<ImageSwipe> {
  int selectedPageView = 0;
  @override
  Widget build(BuildContext context) {
    return  Container(
        height:400,
        child: Stack(
          children: [
            PageView(
              onPageChanged: (num){
                setState(() {
                  selectedPageView = num;
                });
              },
              children: [
                for(var imageIndex = 0 ; imageIndex<widget.imageList.length;imageIndex++)
                  Container(
                    child: Image.network("${widget.imageList[imageIndex]}",fit: BoxFit.cover,),
                  )
              ],
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Color(0xff000221).withOpacity(0.8),
                ),
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for(var imageIndex = 0 ; imageIndex<widget.imageList.length;imageIndex++)
                      AnimatedContainer(
                        duration: Duration(microseconds: 500),
                        curve: Curves.easeOutCirc,
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: selectedPageView == imageIndex?60:30,
                        height:10,
                        decoration: BoxDecoration(
                          color: selectedPageView == imageIndex?Colors.white:Colors.white.withOpacity(0.3),
                          borderRadius: BorderRadiusDirectional.circular(30.0)
                        ),

                      )
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
