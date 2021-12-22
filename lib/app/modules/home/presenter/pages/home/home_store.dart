
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/usecases/get_player_audio.dart';

part 'home_store.g.dart';


class HomeController = HomeStoreBase with _$HomeController;

abstract class HomeStoreBase with Store {
  final GetPlayerUsecase repository;
  HomeStoreBase(this.repository);

  Future<int> playerAudio(BuildContext context) async {
    var audio = await repository.play();
    audio.fold(
      (l) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(l.message),
          backgroundColor: Colors.red,
        ));
      }, 
      (r) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Conectando ao servidor"),
          duration: Duration(seconds: 8),
          backgroundColor: Colors.blue,
        ));
      }
    );
  }
  
  Future<int> playerAudioPause(BuildContext context) async {
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