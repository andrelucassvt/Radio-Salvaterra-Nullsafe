import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:radiosalvaterrafm/Util/Global.dart';
import 'package:radiosalvaterrafm/Views/HomePage/Home.dart';
import 'package:radiosalvaterrafm/Util/controller/controller.dart';
import 'Chat/Chat.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
class BottomNavegar extends StatefulWidget {
  @override
  _BottomNavegarState createState() => _BottomNavegarState();
}

class _BottomNavegarState extends State<BottomNavegar> with TickerProviderStateMixin{
  final _pages = [HomePage(), Chat()];
  var _tabs = <Tab>[
    Tab(
      icon: Icon(Icons.home),
      text: 'Home',
    ),
    Tab(
      icon: Icon(Icons.message),
      text: 'Chat',
    ),
  ];
  TabController _tabController;
  int _currentIndex = 0;
  Controller _controller = Controller();
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _tabController = TabController(
        length: _pages.length,
        vsync: this
      );
      _controller.initData();
    }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=>false,
      child: Scaffold(
        body: TabBarView(
            controller: _tabController,
            children: _pages,
          ),
          
          bottomNavigationBar: Material(
            color: Colors.blue,
            child: TabBar(
              tabs: _tabs,
              controller: _tabController,
            ),
          )
      ),
    );
  }
}