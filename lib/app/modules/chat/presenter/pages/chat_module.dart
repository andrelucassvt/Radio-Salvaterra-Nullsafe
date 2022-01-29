import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/usecases/enviar_mensagem_usecases.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/usecases/get_comentarios_usecases.dart';
import 'package:radiosalvaterrafm/app/modules/chat/external/datasource/chat_datasource_impl.dart';
import 'package:radiosalvaterrafm/app/modules/chat/infra/repository/chat_repository_impl.dart';
import 'package:radiosalvaterrafm/app/modules/chat/presenter/pages/chat_page.dart';
import 'package:radiosalvaterrafm/app/modules/chat/presenter/stores/enviar_comentario/enviarcomentario_store.dart';
import 'package:radiosalvaterrafm/app/modules/chat/presenter/stores/get_comentarios/get_comentarios_store.dart';

class ChatModule extends WidgetModule{
  @override
  List<Bind<Object>> get binds => [
    Bind((i) => ChatDatasourceImpl()),
    Bind((i) => ChatRepositoryImpl(i<ChatDatasourceImpl>())),
    Bind((i) => EnviarComentarioUsecasesImpl(i<ChatRepositoryImpl>())),
    Bind((i) => GetComentariosUsecasesImpl(i<ChatRepositoryImpl>())),
    Bind.factory((i) => EnviarcomentarioStore(i<EnviarComentarioUsecasesImpl>())),
    Bind.singleton((i) => GetComentariosStore(i<GetComentariosUsecasesImpl>())),
  ];

  @override
  Widget get view => ChatPage(); 
}