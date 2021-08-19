import 'package:flutter_modular/flutter_modular.dart';
import 'package:radiosalvaterrafm/app/modules/chat/chat_module.dart';
import 'package:radiosalvaterrafm/app/modules/chat/chat_page.dart';
import 'package:radiosalvaterrafm/app/modules/info/info_module.dart';
import 'package:radiosalvaterrafm/app/modules/start/start_module.dart';

import 'modules/home/home_module.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: StartModule()),
  ];

}