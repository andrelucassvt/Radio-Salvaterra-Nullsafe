import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mobx/mobx.dart';
import 'package:radiosalvaterrafm/app/modules/chat/service/chat_service.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'chat_store.g.dart';

class ChatStore = ChatStoreBase with _$ChatStore;
abstract class ChatStoreBase with Store {
  final ChatService service;
  ChatStoreBase(this.service);

  @observable
  GoogleSignIn googleSignIn = GoogleSignIn();

  @observable
  User? currentUser;

  @observable
  TextEditingController mensagem = TextEditingController();

  @observable
  GlobalKey<FormState> validacao = GlobalKey<FormState>();

  @action
  void setUser(User? user)=> currentUser = user;
  
  @action
  enviarMensagem({required String texto, required User currentUser}) async {
    await service.enviarMensagem(texto: texto, currentUser: currentUser);
  }

  @action
  Future<User?> loginGoogle(BuildContext context) async {
    if (currentUser != null) return currentUser;

    try {
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      var authResult = await FirebaseAuth.instance
          .signInWithCredential(credential);

      final User user = authResult.user!;

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
  @action
  Future<User?> loginApple(BuildContext context) async {
    if (currentUser != null) return currentUser;

    try {
      AuthorizationCredentialAppleID appleResult= await  SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ]
      );
      
      final AuthCredential credential = OAuthProvider('apple.com').credential(
        accessToken: appleResult.authorizationCode,
        idToken: appleResult.identityToken,
      );

      var authResult = await FirebaseAuth.instance
          .signInWithCredential(credential);

      final User user = authResult.user!;

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