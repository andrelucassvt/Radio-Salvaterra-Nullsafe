import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/entities/comentario_entity.dart';

class ComentarioMapper extends ComentarioEntity {
  final String? id;
  final String? nome;
  final String? perfil;
  final String? message;

  ComentarioMapper({
    this.id,
    this.nome,
    this.perfil,
    this.message,
  });

  factory ComentarioMapper.fromMap(Map<String, dynamic> map) {
    return ComentarioMapper(
      id: map['id'] ?? '',
      nome: map['nome'] ?? '',
      perfil: map['perfil'] ?? '',
      message: map['message'] ?? '',
    );
  }

  factory ComentarioMapper.fromDocument(DocumentSnapshot map) {
    return ComentarioMapper(
      id: map['uid'] ?? '',
      nome: map['sendName'] ?? '',
      perfil: map['sendPhotourl'] ?? '',
      message: map['Texto'] ?? '',
    );
  }

  static List<ComentarioMapper> fromJsonList(List list) {
    if (list == null) {
      return [];
    }
    return list.map((e) => ComentarioMapper.fromMap(e)).toList();
  }
}
