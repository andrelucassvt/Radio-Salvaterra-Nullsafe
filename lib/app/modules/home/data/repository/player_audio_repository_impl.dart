import 'package:dartz/dartz.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/datasource/player_radio_datasource.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/error/player_audio_error.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/repository/player_audio_repository.dart';

class PlayerAudioRepositoryImpl implements PlayerAudiorRepository{

  final PlayerAudioDatasource player;
 PlayerAudioRepositoryImpl(this.player);

  @override
  Future<Either<PlayerAudioError, void>> playerAudio() async {
    try {
      var radio = await player.playerAudio();
      return Right(radio);
    } on PlayerAudioError catch (e) {
      throw Left(PlayerAudioError('Erro ao reproduzir audio'));
    }
  }

  @override
  Future<Either<PlayerAudioError, void>> pauseAudio() async {
    try {
      var radio = await player.pauseAudio();
      return Right(radio);
    } on PlayerAudioError catch (e) {
      throw Left(PlayerAudioError('Erro ao pausar audio'));
    }
  }
  
}