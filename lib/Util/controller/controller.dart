import 'package:flutter_radio/flutter_radio.dart';
import 'package:mobx/mobx.dart';
import 'package:radiosalvaterrafm/Util/Global.dart';
part 'controller.g.dart';

class Controller = ControllerBase with _$Controller; 

abstract class ControllerBase with Store{
  

  @action
  playMusic() async {
    await FlutterRadio.playOrPause(url: Global.streamUrl);
  }

  @action
  pauseMusic() async {
    await FlutterRadio.pause(url: Global.streamUrl);
  }

  @action
  initData()async{
    await FlutterRadio.audioStart();
  }
}

//flutter pub run build_runner build