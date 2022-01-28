import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/dto/send_message_dto.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/entities/comentario_entity.dart';
import 'package:radiosalvaterrafm/app/modules/chat/presenter/pages/chat_store.dart';
import 'package:radiosalvaterrafm/app/modules/chat/presenter/stores/enviar_comentario/enviarcomentario_store.dart';
import 'package:radiosalvaterrafm/app/modules/chat/presenter/widgets/comentarios.dart';
import 'package:share/share.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends ModularState<ChatPage, ChatStore> {
  final enviarComentarioStore = Modular.get<EnviarcomentarioStore>();

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      controller.setUser(user);
    });
    enviarComentarioStore.addListener(() { 
      final value = enviarComentarioStore.value;
      if (value is EnviarcomentarioSucess) {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Comentario enviado com sucesso'),
          backgroundColor: Colors.blue,
        ));
      }
      if (value is EnviarcomentarioFailure) {
        return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value.error.message),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  @override
  void dispose() {
    enviarComentarioStore.node.dispose();
    enviarComentarioStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AutoSizeText(
          'Chat Salvaterra FM',
          maxLines: 1,
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
        actions: [
          IconButton(
            onPressed: () {
              Share.share('''Baixe agora o aplicativo da Salvaterra FM.\nhttps://play.google.com/store/apps/details?id=com.andre.radiosalvaterrafm''');
            },
            icon: Icon(Icons.share),
          )
        ],
      ),
      body: Form(
        key: enviarComentarioStore.validacao,
        child: Column(
          children: [
            Expanded(child: Observer(
              builder: (_) {
                if (controller.currentUser == null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Faça login com o google para ter acesso ao chat'),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          child: Text('Login com google'),
                          onPressed: () => controller.loginGoogle(context),
                        )
                      ],
                    ),
                  );
                }

                if (controller.observableStream.hasError) {
                  return Center(
                    child: ElevatedButton(
                      child: Text('Erro ao carregar comentários :('),
                      onPressed: () {
                        controller.getComentarios();
                      },
                    ),
                  );
                }
                if (controller.observableStream.data == null) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<ComentarioEntity> list = controller.observableStream.data;

                return ListView.builder(
                  itemCount: list.length,
                  reverse: true,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return ComentariosWidget(
                      comentarioEntity: list[index],
                    );
                  },
                );
              },
            )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      focusNode: enviarComentarioStore.node,
                      controller: enviarComentarioStore.comentario,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        hintText: 'Enviar uma mensagem',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Campo vazio!!";
                        }
                        return '';
                      },
                    )
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ValueListenableBuilder<EnviarcomentarioState>(
                    valueListenable: enviarComentarioStore,
                    builder: (context, value ,child) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: () {
                            if (controller.currentUser != null) {
                              return enviarComentarioStore.enviarMensagem(
                                sendMessageDto: SendMessageDto(
                                  texto:enviarComentarioStore.comentario.text,
                                  user: controller.currentUser
                                ),
                              );
                            }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('Faça login com o google para enviar uma mensagem'),
                              backgroundColor: Colors.red,
                            ));
                          },
                        ),
                      );
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
