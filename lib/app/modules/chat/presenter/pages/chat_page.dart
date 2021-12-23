import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/dto/send_message_dto.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/entities/comentario_entity.dart';
import 'package:radiosalvaterrafm/app/modules/chat/presenter/pages/chat_store.dart';
import 'package:radiosalvaterrafm/app/modules/chat/presenter/widgets/comentarios.dart';
import 'package:share/share.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends ModularState<ChatPage,ChatStore> {
  
  FocusNode node = FocusNode();
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance
      .authStateChanges()
      .listen((user) {
        controller.setUser(user);
      }
    );
  }
  @override
  void dispose() {
    node.dispose();
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
            onPressed: (){
              Share.share('''Baixe agora o aplicativo da Salvaterra FM.\nhttps://play.google.com/store/apps/details?id=com.andre.radiosalvaterrafm''');
            }, 
            icon: Icon(Icons.share)
          )
        ],
      ),
      body: Form(
        key:controller.validacao,
        child: Column(
          children: [
            Expanded(
              child: Observer(
                builder: (_){

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
                            onPressed: () => controller.loginGoogle(context)
                          )
                        ],
                      ),
                    );
                  }

                  if (controller.observableStream.hasError) {
                    return Center(
                      child: ElevatedButton(
                        child: Text('Erro ao carregar comentários :('),
                        onPressed: (){
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
                    itemBuilder: (context,index){
                      return ComentariosWidget(
                        comentarioEntity: list[index],
                      );
                    },
                  );
                },
              )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        focusNode: node,
                        controller: controller.mensagem,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          hintText: 'Enviar uma mensagem',
                        ),
                        validator: (value){
                          if(value.isEmpty){
                            return "Campo vazio!!";
                          }
                        },
                      )
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: IconButton(
                        icon: Icon(Icons.send),
                          onPressed: (){
                            controller.enviarMensagem(
                              sendMessageDto: SendMessageDto(
                                texto: controller.mensagem.text,
                                user: controller.currentUser
                              ), 
                              context: context,
                            );
                            node.unfocus();
                          },
                      ),
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