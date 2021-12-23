import 'package:dartz/dartz.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/dto/send_message_dto.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/entities/comentario_entity.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/error/comentario_error.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/error/envio_message_error.dart';

abstract class ChatRepository {
  Future<Either<EnvioComentarioError,void>> enviarComentario(SendMessageDto sendMessageDto);
  Stream<List<ComentarioEntity>>  getComentarios();
}