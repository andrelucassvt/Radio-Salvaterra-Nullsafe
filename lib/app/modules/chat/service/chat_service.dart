import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:radiosalvaterrafm/app/shared/exception/error_message.dart';

class ChatService {
  
  Future enviarMensagem({required String texto, required User currentUser})async{
    try {
      Map<String, dynamic> data = {
        "uid" : currentUser.uid,
        "sendName": currentUser.displayName ?? 'Apple user',
        "Texto": texto,
        "sendPhotourl": currentUser.photoURL ?? 'https://firebasestorage.googleapis.com/v0/b/chat-radio-80a3e.appspot.com/o/kisspng-computer-icons-avatar-user-profile-clip-art-5af95fab3b2d13.0220186015262923952424.jpg?alt=media&token=56d2f75b-4ab9-4fb1-93d2-703831091156',
        "Time": FieldValue.serverTimestamp()
      };
      await FirebaseFirestore.instance.collection('Mensagens1').add(data);

    } on ErrorMessage catch (e) {
      return 'Erro ao enviar mensagem';
    }
  }

}