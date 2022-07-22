import 'package:flutter/material.dart';
import 'package:radiosalvaterrafm/app/modules/chat/presenter/pages/chat_module.dart';
import 'package:radiosalvaterrafm/app/modules/home/presenter/pages/home/home_module.dart';

class StartPage extends StatefulWidget {
  @override
  StartPageState createState() => StartPageState();
}

class StartPageState extends State<StartPage> with TickerProviderStateMixin {
  List<Widget> _pages = [HomeModule(), ChatModule()];
  var _tabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.message),
      label: 'Chat',
    ),
  ];
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _pages[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: _tabs,
          currentIndex: _currentIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ));
  }
}
