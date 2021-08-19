import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_modular/flutter_modular.dart';
import '../home/home_store.dart'; 

import 'home_page.dart';
 
class HomeModule extends WidgetModule {
  @override
  final List<Bind> binds = [];

 @override
 final List<ModularRoute> routes = [
   ChildRoute(Modular.initialRoute, child: (_, args) => HomePage()),
 ];

  @override
  Widget get view => HomePage();
}