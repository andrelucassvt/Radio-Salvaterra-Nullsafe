import 'package:dartz/dartz.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/error/player_audio_error.dart';

abstract class PlayerAudiorRepository {
  
  Future<Either<PlayerAudioError,int>> playerAudio();
  Future<Either<PlayerAudioError,int>> pauseAudio();

}