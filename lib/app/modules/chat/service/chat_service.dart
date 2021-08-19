import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:radiosalvaterrafm/app/shared/exception/error_message.dart';

class ChatService {
  
  Future enviarMensagem({required String texto, required User currentUser})async{
    try {
      Map<String, dynamic> data = {
        "uid" : currentUser.uid,
        "sendName": currentUser.displayName,
        "Texto": texto,
        "sendPhotourl": currentUser.photoURL,
        "Time": FieldValue.serverTimestamp()
      };
      await FirebaseFirestore.instance.collection('Mensagens2').add(data);

    } on ErrorMessage catch (e) {
      return 'Erro ao enviar mensagem';
    }
  }

}