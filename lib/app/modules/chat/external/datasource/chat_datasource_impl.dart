import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/dto/send_message_dto.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/entities/comentario_entity.dart';
import 'package:radiosalvaterrafm/app/modules/chat/external/mappers/comentario_mapper.dart';
import 'package:radiosalvaterrafm/app/modules/chat/infra/datasource/chat_datasource.dart';

class ChatDatasourceImpl implements ChatDatasource{

  @override
  Future<void> enviarMensagem(SendMessageDto sendMessageDto) async {
      Map<String, dynamic> data = {
        "uid" : sendMessageDto.user.uid,
        "sendName": sendMessageDto.user.displayName ?? 'User anônimo',
        "Texto": sendMessageDto.texto,
        "sendPhotourl": sendMessageDto.user.photoURL ?? 'https://firebasestorage.googleapis.com/v0/b/chat-radio-80a3e.appspot.com/o/kisspng-computer-icons-avatar-user-profile-clip-art-5af95fab3b2d13.0220186015262923952424.jpg?alt=media&token=56d2f75b-4ab9-4fb1-93d2-703831091156',
        "Time": FieldValue.serverTimestamp()
      };
      await FirebaseFirestore.instance.collection('Mensagens1').add(data);
  }

  @override
  Stream<List<ComentarioEntity>> getComentarios() {
    var list = FirebaseFirestore.instance
      .collection('Mensagens1')
      .orderBy('Time',descending: true)
      .snapshots()
      .map((event) {
        return event.docs.map((e) {
          return ComentarioMapper.fromDocument(e);
        }).toList();
      });
    return list;
  }
  
}