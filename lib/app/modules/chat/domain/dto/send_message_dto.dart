import 'package:firebase_auth/firebase_auth.dart';

class SendMessageDto {
  String texto;
  User user;

  SendMessageDto({
    this.texto,
    this.user,
  });
  
}
