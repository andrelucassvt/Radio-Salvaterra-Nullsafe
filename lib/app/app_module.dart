import 'package:flutter_modular/flutter_modular.dart';
import 'package:radiosalvaterrafm/app/modules/start/start_page.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
    ChildRoute('/', child: (context, args) => StartPage()),
  ];
}