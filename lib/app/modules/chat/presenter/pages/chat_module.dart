import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/usecases/enviar_mensagem_usecases.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/usecases/get_comentarios_usecases.dart';
import 'package:radiosalvaterrafm/app/modules/chat/external/datasource/chat_datasource_impl.dart';
import 'package:radiosalvaterrafm/app/modules/chat/infra/repository/chat_repository_impl.dart';
import 'package:radiosalvaterrafm/app/modules/chat/presenter/pages/chat_page.dart';
import 'package:radiosalvaterrafm/app/modules/chat/presenter/pages/chat_store.dart';

class ChatModule extends WidgetModule{
  @override
  List<Bind<Object>> get binds => [
    Bind((i) => ChatDatasourceImpl()),
    Bind((i) => ChatRepositoryImpl(i<ChatDatasourceImpl>())),
    Bind((i) => EnviarMensagemUsecasesImpl(i<ChatRepositoryImpl>())),
    Bind((i) => GetComentariosUsecasesImpl(i<ChatRepositoryImpl>())),
    Bind.singleton((i) => ChatStore(
      enviarMensagemUsecases: i<EnviarMensagemUsecasesImpl>(),
      getComentariosUsecases: i<GetComentariosUsecasesImpl>(),
    ))
  ];

  @override
  Widget get view => ChatPage(); 
}