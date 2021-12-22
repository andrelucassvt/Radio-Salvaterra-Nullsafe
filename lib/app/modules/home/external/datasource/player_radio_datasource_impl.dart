import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/error/audio_error.dart';
import 'package:radiosalvaterrafm/app/modules/home/infra/datasource/player_radio_datasource.dart';

@Injectable(singleton: true)
class PlayerAudioDatasourceImpl implements PlayerAudioDatasource {
  final AudioPlayer player;
  PlayerAudioDatasourceImpl(this.player);

  @override
  Future<int> playerAudio() {
    if (player.state == PlayerState.STOPPED || player.state == PlayerState.PAUSED) {
      player.setUrl('http://ia802708.us.archive.org/3/items/count_monte_cristo_0711_librivox/count_of_monte_cristo_001_dumas.mp3');
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