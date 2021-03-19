import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:radiosalvaterrafm/Views/HomePage/Home.dart';
import 'Chat/Chat.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
class BottomNavegar extends StatefulWidget {
  @override
  _BottomNavegarState createState() => _BottomNavegarState();
}

class _BottomNavegarState extends State<BottomNavegar> {
  var _pages = [HomePage(), Chat()];
  int _currentIndex = 0;
  GlobalKey _bottomNavigationKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
        body: _pages[_currentIndex],
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            items: <Widget>[
              Icon(
                Icons.radio, 
                size: 30,
                color: _currentIndex == 1? 
                  Colors.black
                  :
                  Colors.white
                  ,
                ),
              Icon(
                Icons.message, 
                size: 30,
                color: _currentIndex == 0? 
                  Colors.black
                  :
                  Colors.white
                  ,
                ),
            ],
            buttonBackgroundColor: Colors.black,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
      ),
    );
  }
}