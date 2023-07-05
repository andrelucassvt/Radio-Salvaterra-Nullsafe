import 'package:firebase_auth/firebase_auth.dart';

class SendMessageDto {
  final String texto;
  final User user;

  SendMessageDto({
    required this.texto,
    required this.user,
  });
}
