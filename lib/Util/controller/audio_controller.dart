import 'package:flutter_radio/flutter_radio.dart';
import 'package:mobx/mobx.dart';
import 'package:radiosalvaterrafm/Util/Global.dart';
part 'audio_controller.g.dart';

class AudioController = _AudioController with _$AudioController; 

abstract class _AudioController with Store{
  

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