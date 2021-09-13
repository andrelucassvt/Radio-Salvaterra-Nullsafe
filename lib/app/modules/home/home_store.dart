import 'package:audioplayers/audioplayers.dart';
import 'package:mobx/mobx.dart';
import 'package:radiosalvaterrafm/app/shared/global.dart';

class HomeStore with Store {

  static final HomeStore _singleton = HomeStore._internal();

  factory HomeStore(){
    return _singleton;
  }

  HomeStore._internal();

  @observable
  AudioPlayer audioPlayer = AudioPlayer();

  @action
  Future handlePressed() async {
    switch (audioPlayer.state) {
      case PlayerState.COMPLETED:
      case PlayerState.STOPPED:
        audioPlayer.setUrl(Global.streamUrl,isLocal: false);
        audioPlayer.resume();
        break;

      case PlayerState.PAUSED:
        audioPlayer.resume();
        break;

      case PlayerState.PLAYING:
        audioPlayer.stop();
        break;
    }
  }
}