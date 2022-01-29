import 'package:dartz/dartz.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/dto/send_message_dto.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/error/envio_message_error.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/repository/chat_repository.dart';

abstract class EnviarComentarioUsecases {
  Future<Either<EnvioComentarioError,void>> call(SendMessageDto sendMessageDto);
}

class EnviarComentarioUsecasesImpl implements EnviarComentarioUsecases{
  final ChatRepository repository;
  EnviarComentarioUsecasesImpl(this.repository);
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