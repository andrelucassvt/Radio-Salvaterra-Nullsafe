import 'package:dartz/dartz.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/error/player_audio_error.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/repository/player_audio_repository.dart';

abstract class GetPlayerUsecase {
  Future<Either<PlayerAudioError,int>> play();
  Future<Either<PlayerAudioError,int>> pause();
}


class GetPlayerUsecaseImpl implements GetPlayerUsecase {
  final PlayerAudiorRepository repository;
  GetPlayerUsecaseImpl(this.repository);

  @override
  Future<Either<PlayerAudioError, int>> pause() async {
    return await repository.pauseAudio();
  }

  @override
  Future<Either<PlayerAudioError, int>> play() async {
    return await repository.playerAudio();
  }
  
}