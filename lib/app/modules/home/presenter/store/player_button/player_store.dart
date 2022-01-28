import 'package:flutter/material.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/usecases/get_player_audio.dart';
import 'package:radiosalvaterrafm/app/modules/home/presenter/store/player_button/player_store_state.dart';

class PlayerStore extends ValueNotifier<PlayerStoreState> {
  final GetPlayerUsecase repository;
  PlayerStore(this.repository) : super(PlayerStoreInitial());

  Future<void> playerAudio(BuildContext context) async {
    value = PlayerStoreLoading();
    var audio = await repository.play();
    audio.fold(
      (l) {value = PlayerStoreFailure(error: l);}, 
      (r) {Future.delayed(Duration(seconds: 10),() => value = PlayerStoreSucess());}
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