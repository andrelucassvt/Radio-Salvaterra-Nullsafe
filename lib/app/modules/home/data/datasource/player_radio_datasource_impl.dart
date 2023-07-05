import 'package:audioplayers/audioplayers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/datasource/player_radio_datasource.dart';

class PlayerAudioDatasourceImpl implements PlayerAudioDatasource {
  final AudioPlayer player;
  PlayerAudioDatasourceImpl(this.player);

  @override
  Future<void> playerAudio() async {
    if (player.state == PlayerState.stopped ||
        player.state == PlayerState.paused) {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection('status')
          .doc('att')
          .get();
      Map<String, dynamic> data = snapshot.data() ?? {};
      print(data['urlRadio']);
      player.play(UrlSource(data['urlRadio']));
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
