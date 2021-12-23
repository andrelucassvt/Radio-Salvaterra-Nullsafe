import 'package:dartz/dartz.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/error/player_audio_error.dart';

abstract class PlayerAudiorRepository {
  
  Future<Either<PlayerAudioError,void>> playerAudio();
  Future<Either<PlayerAudioError,void>> pauseAudio();

}