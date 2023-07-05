import 'package:flutter/material.dart';
import 'package:radiosalvaterrafm/app/modules/start/start_page.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: StartPage(),
    );
  }
}
