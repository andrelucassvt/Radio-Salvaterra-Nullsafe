import 'package:audioplayers/audioplayers.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/datasource/player_radio_datasource.dart';
import 'package:radiosalvaterrafm/app/shared/global.dart';

class PlayerAudioDatasourceImpl implements PlayerAudioDatasource {
  final AudioPlayer player;
  PlayerAudioDatasourceImpl(this.player);

  @override
  Future<void> playerAudio() async {
    if (player.state == PlayerState.stopped ||
        player.state == PlayerState.paused) {
      player.setSource(UrlSource(HelperGlobal.streamUrl));
      return player.resume();
    }
    if (player.state == PlayerState.playing) {
      return player.stop();
    }
  }

  @override
  Future<void> pauseAudio() async {
    if (player.state == PlayerState.playing) {
      return player.stop();
    }
  }
}
