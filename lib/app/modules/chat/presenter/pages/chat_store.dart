import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/dto/send_message_dto.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/entities/comentario_entity.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/error/comentario_error.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/usecases/enviar_mensagem_usecases.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/usecases/get_comentarios_usecases.dart';

part 'chat_store.g.dart';

class ChatStore = ChatStoreBase with _$ChatStore;
abstract class ChatStoreBase with Store {
  final EnviarComentarioUsecases enviarMensagemUsecases;
  final GetComentariosUsecases getComentariosUsecases;

  ChatStoreBase({
    this.enviarMensagemUsecases,
    this.getComentariosUsecases,
  }){
    getComentarios();
  }

  @observable
  ObservableStream<List<ComentarioEntity>> observableStream;

  @observable
  GoogleSignIn googleSignIn = GoogleSignIn();

  @observable
  User currentUser;

  @action
  void setUser(User user)=> currentUser = user;
  

  @action
  getComentarios() {
    observableStream = getComentariosUsecases().asObservable();
  }

  @action
  Future<User> loginGoogle(BuildContext context) async {
    if (currentUser != null) return currentUser;

    try {
      final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      var authResult = await FirebaseAuth.instance
          .signInWithCredential(credential);

      final User user = authResult.user;

      return user;
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text('Não foi possivel fazer login')
        ),
      );
    }
  }
}