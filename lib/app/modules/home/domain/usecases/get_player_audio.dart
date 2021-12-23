import 'package:dartz/dartz.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/error/player_audio_error.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/repository/player_audio_repository.dart';

abstract class GetPlayerUsecase {
  Future<Either<PlayerAudioError,void>> play();
  Future<Either<PlayerAudioError,void>> pause();
}


class GetPlayerUsecaseImpl implements GetPlayerUsecase {
  final PlayerAudiorRepository repository;
  GetPlayerUsecaseImpl(this.repository);

  @override
  Future<Either<PlayerAudioError, void>> pause() async {
    return await repository.pauseAudio();
  }

  @override
  Future<Either<PlayerAudioError, void>> play() async {
    return await repository.playerAudio();
  }
  
}