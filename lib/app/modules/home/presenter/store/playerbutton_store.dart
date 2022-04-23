import 'package:flutter/material.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/error/player_audio_error.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/usecases/get_player_audio.dart';

part 'playerbutton_state.dart';

class PlayerbuttonStore extends ValueNotifier<PlayerbuttonState> {
  final GetPlayerUsecase repository;
  PlayerbuttonStore(this.repository) : super(PlayerbuttonInitial());

 Future<void> playerAudio() async {
    value = PlayerbuttonLoading();
    var audio = await repository.play();
    audio.fold(
      (failure) => value = PlayerbuttonFailure(failure), 
      (sucess) => Future.delayed(Duration(seconds: 10),() => value = PlayerbuttonSucess())
    );
  }

  Future<void> playerAudioPause(BuildContext context) async {
    var audio = await repository.pause();
    audio.fold(
      (l) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l.message),
          backgroundColor: Colors.red,
        ));
      }, 
      (r) {}
    );
  }
}
