import 'package:radiosalvaterrafm/app/modules/home/domain/error/player_audio_error.dart';

abstract class PlayerStoreState {}

class PlayerStoreInitial implements PlayerStoreState {}

class PlayerStoreLoading implements PlayerStoreState {}

class PlayerStoreSucess implements PlayerStoreState {}

class PlayerStoreFailure implements PlayerStoreState {
  final PlayerAudioError error;
  PlayerStoreFailure({this.error});
}