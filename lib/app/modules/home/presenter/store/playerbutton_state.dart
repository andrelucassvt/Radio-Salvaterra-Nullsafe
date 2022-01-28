part of 'playerbutton_store.dart';

@immutable
abstract class PlayerbuttonState {}

class PlayerbuttonInitial extends PlayerbuttonState {}

class PlayerbuttonLoading extends PlayerbuttonState {}

class PlayerbuttonSucess extends PlayerbuttonState {}

class PlayerbuttonFailure extends PlayerbuttonState {
  final PlayerAudioError error;
  PlayerbuttonFailure(this.error);
}
