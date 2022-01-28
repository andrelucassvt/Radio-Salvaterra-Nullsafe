import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/error/player_audio_error.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/usecases/get_player_audio.dart';

part 'playerbutton_state.dart';

class PlayerbuttonCubit extends Cubit<PlayerbuttonState> {
  final GetPlayerUsecase repository;
  PlayerbuttonCubit(this.repository) : super(PlayerbuttonInitial());

 Future<void> playerAudio() async {
    emit(PlayerbuttonLoading());
    var audio = await repository.play();
    audio.fold(
      (failure) => emit(PlayerbuttonFailure(failure)), 
      (sucess) {Future.delayed(Duration(seconds: 10),() => emit(PlayerbuttonSucess()));}
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
