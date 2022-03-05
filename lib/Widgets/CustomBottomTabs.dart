import 'package:ecommerce_sport/UI/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BottomTabs extends StatefulWidget {
  final int selectedTab;
  final Function(int) tabPressed;
  BottomTabs({this.selectedTab, this.tabPressed});
  @override
  _BottomTabsState createState() => _BottomTabsState();
}

class _BottomTabsState extends State<BottomTabs> {
  int _selectedTab = 0;
  @override
  @override
  Widget build(BuildContext context) {
    _selectedTab = widget.selectedTab ?? 0;
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff000221),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5.0,
                blurRadius: 10.0)
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomButtonTab(
            iconData: Icons.home_rounded,
            selected: _selectedTab == 0 ? true : false,
            onPressed: () {
              widget.tabPressed(0);
            },
          ),
          BottomButtonTab(
            iconData: Icons.search_rounded,
            selected: _selectedTab == 1 ? true : false,
            onPressed: () {
              widget.tabPressed(1);
            },
          ),
          BottomButtonTab(
            iconData: Icons.bookmark_border_rounded,
            selected: _selectedTab == 2 ? true : false,
            onPressed: () {
              widget.tabPressed(2);
            },
          ),
          BottomButtonTab(
            iconData: Icons.logout,
            selected: _selectedTab == 3 ? true : false,
            onPressed: () {
              widget.tabPressed(3);
              FirebaseAuth.instance.signOut();
              Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage()));
            },
          ),
        ],
      ),
    );
  }
}

class BottomButtonTab extends StatelessWidget {
  final String imagePath;
  final IconData iconData;
  final bool selected;
  final Function onPressed;
  const BottomButtonTab(
      {Key key, this.imagePath, this.selected, this.onPressed, this.iconData})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    bool _selected = selected ?? false;
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: _selected ? Colors.white : Colors.transparent,
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), topLeft: Radius.circular(20)),
        ),
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 24),
        child: Icon(
          iconData ?? Icons.home_rounded,
          size: 35,
          color: _selected ? Colors.black : Colors.white,
        ),
      ),
    );
  }
}
