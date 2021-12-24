import 'package:dartz/dartz.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/dto/send_message_dto.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/error/envio_message_error.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/repository/chat_repository.dart';

abstract class EnviarMensagemUsecases {
  Future<Either<EnvioComentarioError,void>> call(SendMessageDto sendMessageDto);
}

class EnviarMensagemUsecasesImpl implements EnviarMensagemUsecases{
  final ChatRepository repository;
  EnviarMensagemUsecasesImpl(this.repository);
  @override
  Future<Either<EnvioComentarioError,void>> call(SendMessageDto sendMessageDto) async {
    if (sendMessageDto.texto.isEmpty) {
      return left(EnvioComentarioError('Texto está vazio'));
    }
    if (sendMessageDto.user == null) {
      return left(EnvioComentarioError('Error ao encontrar usuário'));
    }
    return await repository.enviarComentario(sendMessageDto);
  }
  
}