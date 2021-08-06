import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:radiosalvaterrafm/app/modules/chat/chat_page.dart';
import 'package:radiosalvaterrafm/app/modules/chat/chat_store.dart';
import 'package:radiosalvaterrafm/app/modules/home/home_page.dart';
import 'package:radiosalvaterrafm/app/modules/home/home_store.dart';
import 'package:radiosalvaterrafm/app/modules/start/start_Page.dart';
import 'package:flutter_modular/flutter_modular.dart';

class StartModule extends Module {
  @override
  final List<Bind> binds = [ 
    Bind((i)=> AudioPlayer()),
    Bind.singleton((i) => HomeStore(i.get<AudioPlayer>())),
    Bind.lazySingleton((i) => ChatStore()),
  ];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/start',child: (context, args) => StartPage()),
  ];
}
