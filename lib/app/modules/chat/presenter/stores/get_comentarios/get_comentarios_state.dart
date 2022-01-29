part of 'get_comentarios_store.dart';

@immutable
abstract class GetComentariosState {}

class GetComentariosInitial extends GetComentariosState {}

class GetComentariosGoogleLoading extends GetComentariosState {}

class GetComentariosLoginGoogleSucess extends GetComentariosState {}

class GetComentariosLoginGoogleError extends GetComentariosState {}
