import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/error/audio_error.dart';
import 'package:radiosalvaterrafm/app/modules/home/infra/datasource/player_radio_datasource.dart';
import 'package:radiosalvaterrafm/app/shared/global.dart';

@Injectable(singleton: true)
class PlayerAudioDatasourceImpl implements PlayerAudioDatasource {
  final AudioPlayer player;
  PlayerAudioDatasourceImpl(this.player);

  @override
  Future<int> playerAudio() {
    if (player.state == PlayerState.STOPPED || player.state == PlayerState.PAUSED) {
      player.setUrl(HelperGlobal.streamUrl);
      return player.resume();
    }
    if (player.state == PlayerState.PLAYING) {
      return player.stop();
    }
  }

  @override
  Future<int> pauseAudio() {
    if(player.state == PlayerState.PLAYING){
      return player.stop();
    }
  }
}