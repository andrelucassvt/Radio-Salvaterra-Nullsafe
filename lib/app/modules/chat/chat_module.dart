import 'package:flutter/src/widgets/framework.dart';
import 'package:radiosalvaterrafm/app/modules/chat/chat_Page.dart';
import 'package:radiosalvaterrafm/app/modules/chat/chat_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ChatModule extends WidgetModule {
  @override
  final List<Bind> binds = [];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => ChatPage()),
  ];

  @override
  Widget get view => ChatPage();
}
