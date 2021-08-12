import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:radiosalvaterrafm/app/modules/chat/chat_store.dart';
import 'package:radiosalvaterrafm/app/modules/chat/widgets/comentarios.dart';
import 'package:share/share.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends ModularState<ChatPage,ChatStore> {

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
  enviarMensagem({required String texto, required User currentUser}) async {
    try {
      await controller.enviarMensagem(texto: texto, currentUser: currentUser);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mensagem enviada'),
        )
      );
      controller.mensagem.clear();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Mensagem não enviada'),
        )
      );
      controller.mensagem.clear();  
    }
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
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Mensagens2').orderBy('Time',descending: true).snapshots(),
                builder: (context,snapshot){
                  
                  if (snapshot.hasError) {
                    return Center(
                      child: AutoSizeText(
                        'Erro ao carregar dados :(',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    );
                  } else if(!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } 
                  List<DocumentSnapshot> doc = snapshot.data!.docs.toList();
                  if(doc.isEmpty){
                    return Center(
                      child: AutoSizeText(
                        'Sem comentários :(',
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 20
                        ),
                      ),
                    ); 
                  }
                  return ListView.builder(
                    itemCount: doc.length,
                    reverse: true,
                    shrinkWrap: true,
                    itemBuilder: (context,index){
                      return Comentarios(
                        nome: doc[index]['sendName'],
                        perfil: doc[index]['sendPhotourl'],
                        texto: doc[index]['Texto'],
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
                        controller: controller.mensagem,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          hintText: 'Enviar uma mensagem',
                        ),
                        validator: (value){
                          if(value!.isEmpty){
                            return "Campo vazio!!";
                          }
                        },
                      )
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    //Botao enviar
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: IconButton(
                        icon: Icon(Icons.send),
                          onPressed: (){
                            if (controller.currentUser == null) {
                              controller.getUser(context);
                            } else if (controller.validacao.currentState!.validate()) {
                              enviarMensagem(
                                texto: controller.mensagem.text, 
                                currentUser: controller.currentUser!
                              );
                            }
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