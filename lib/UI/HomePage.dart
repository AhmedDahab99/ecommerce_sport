import 'package:ecommerce_sport/Network/FirebaseServices.dart';
import 'package:ecommerce_sport/Widgets/CustomBottomTabs.dart';
import 'package:ecommerce_sport/taps/HomeTap.dart';
import 'package:ecommerce_sport/taps/SavedTap.dart';
import 'package:ecommerce_sport/taps/SearchTap.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  FirebaseServices _firebaseServices = FirebaseServices();

  PageController _tabPageController;
  int selectTab = 0;

  @override
  void initState() {
    print("UserID: ${_firebaseServices.getUserID()}");
    _tabPageController = PageController();
    super.initState();
  }
  @override
  void dispose() {
    _tabPageController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _tabPageController,
            onPageChanged: (pageNum){
                setState(() {
                  selectTab =pageNum;
                });
            },
            children: [
              HomeTap(),
              SearchTap(),
              SavedTap()
            ],
          ),),
          BottomTabs(
            selectedTab: selectTab,
            tabPressed: (num){
              setState(() {
                _tabPageController.animateToPage(num,
                    duration:Duration(milliseconds: 300) ,
                    curve: Curves.easeInOutExpo
                );
              });
            },
          ),
        ],
      )
    );
  }
}
