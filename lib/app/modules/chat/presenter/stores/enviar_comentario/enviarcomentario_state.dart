part of 'enviarcomentario_store.dart';

@immutable
abstract class EnviarcomentarioState {}

class EnviarcomentarioInitial extends EnviarcomentarioState {}

class EnviarcomentarioSucess extends EnviarcomentarioState {}

class EnviarcomentarioFailure extends EnviarcomentarioState {
  final EnvioComentarioError error;
  EnviarcomentarioFailure(this.error);
}
