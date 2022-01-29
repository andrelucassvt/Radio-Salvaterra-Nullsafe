import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/dto/send_message_dto.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/error/envio_message_error.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/usecases/enviar_mensagem_usecases.dart';

part 'enviarcomentario_state.dart';

class EnviarcomentarioStore extends ValueNotifier<EnviarcomentarioState> {

  final EnviarComentarioUsecases enviarComentarioUsecases;
  EnviarcomentarioStore(this.enviarComentarioUsecases) : super(EnviarcomentarioInitial());

  TextEditingController comentario = TextEditingController();
  GlobalKey<FormState> validacao = GlobalKey<FormState>();
  FocusNode node = FocusNode();
  
  Future<void> enviarMensagem({@required SendMessageDto sendMessageDto}) async {
    var result = await enviarComentarioUsecases(sendMessageDto);
    comentario.clear();
    node.unfocus();
    result.fold(
      (failure) => value = EnviarcomentarioFailure(failure), 
      (sucess) => value = EnviarcomentarioSucess()
    );
  }
}
