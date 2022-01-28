part of 'get_comentarios_store.dart';

@immutable
abstract class GetComentariosState {}

class GetComentariosInitial extends GetComentariosState {}

class GetComentariosLoading extends GetComentariosState {}

class GetComentariosSucess extends GetComentariosState {}

class GetComentariosFailure extends GetComentariosState {}
