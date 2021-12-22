import 'package:radiosalvaterrafm/app/modules/chat/domain/dto/send_message_dto.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/entities/comentario_entity.dart';

abstract class ChatRepository {
  Future<void> enviarComentario(SendMessageDto sendMessageDto);
  Stream<List<ComentarioEntity>>  getComentarios();
}