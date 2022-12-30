import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/usecases/get_comentarios_usecases.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

part 'get_comentarios_state.dart';

class GetComentariosStore extends ValueNotifier<GetComentariosState> {
  final GetComentariosUsecases getComentariosUsecases;
  GetComentariosStore(this.getComentariosUsecases)
      : super(GetComentariosInitial());

  GoogleSignIn googleSignIn = GoogleSignIn();

  User currentUser;

  void setUser(User user) {
    value = GetComentariosGoogleLoading();
    if (user != null) {
      value = GetComentariosLoginGoogleSucess();
    }
    if (user == null) {
      value = GetComentariosLoginGoogleError();
    }
    currentUser = user;
  }

  Future<User> loginApple(BuildContext context) async {
    if (currentUser != null) {
      value = GetComentariosLoginGoogleSucess();
      return currentUser;
    }

    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: credential.identityToken,
      );
      final authResult =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);
      final User user = authResult.user;
      value = GetComentariosLoginGoogleSucess();
      return user;
    } catch (e) {
      value = GetComentariosLoginGoogleError();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text('Não foi possivel fazer login')),
      );
    }
  }

  Future<User> loginGoogle(BuildContext context) async {
    if (currentUser != null) {
      value = GetComentariosLoginGoogleSucess();
      return currentUser;
    }

    try {
      final GoogleSignInAccount googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      var authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);

      final User user = authResult.user;
      value = GetComentariosLoginGoogleSucess();
      return user;
    } catch (error) {
      value = GetComentariosLoginGoogleError();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.red,
            content: Text('Não foi possivel fazer login')),
      );
    }
  }
}
