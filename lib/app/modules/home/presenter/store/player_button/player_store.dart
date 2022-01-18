import 'package:flutter/material.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/usecases/get_player_audio.dart';

class PlayerStore extends ValueNotifier<bool> {
  final GetPlayerUsecase repository;
  PlayerStore(this.repository) : super(false);

  Future<void> playerAudio(BuildContext context) async {
    value = true;
    var audio = await repository.play();
    audio.fold(
      (l) {
        value = false;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l.message),
          backgroundColor: Colors.red,
        ));
      }, 
      (r) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Conectando ao servidor"),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.blue,
        ));
        Future.delayed(Duration(seconds: 6),() => value = false);
      }
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