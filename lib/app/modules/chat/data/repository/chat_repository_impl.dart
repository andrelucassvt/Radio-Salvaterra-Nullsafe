import 'dart:io';
import 'dart:math';

import 'package:radiosalvaterrafm/app/modules/chat/domain/datasource/chat_datasource.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/error/envio_message_error.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/error/comentario_error.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/entities/comentario_entity.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/dto/send_message_dto.dart';
import 'package:dartz/dartz.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {

  final ChatDatasource chatDatasource;
  ChatRepositoryImpl(this.chatDatasource);

  @override
  Future<Either<EnvioComentarioError,void>> enviarComentario(SendMessageDto sendMessageDto) async {
    try {
      var result = await chatDatasource.enviarComentario(sendMessageDto);
      return Right(result);
    } on EnvioComentarioError catch (e) {
      throw Left(EnvioComentarioError('Error ao enviar mensagem'));
    }
  }

  @override
  Stream<List<ComentarioEntity>>  getComentarios() {
    try {
      var lista = chatDatasource.getComentarios();
      return lista;
    } on ComentarioError catch (e) {
      if (e is SocketOption) {
        throw ComentarioError('Verifique sua conexão de internet');
      }
      throw ComentarioError('Error ao carregar comentarios');
    }
  }
  
}