import 'package:flutter/src/widgets/framework.dart';
import 'package:radiosalvaterrafm/app/modules/info/info_page.dart';
import 'package:radiosalvaterrafm/app/modules/info/info_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class InfoModule extends WidgetModule {
  @override
  final List<Bind> binds = [
    Bind.singleton((i) => InfoStore()),
  ];

  @override
  Widget get view => InfoPage();
  
}
