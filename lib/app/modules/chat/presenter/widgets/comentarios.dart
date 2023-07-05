import 'package:flutter/material.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/entities/comentario_entity.dart';

class ComentariosWidget extends StatelessWidget {
  final ComentarioEntity comentarioEntity;

  ComentariosWidget({
    required this.comentarioEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
                backgroundImage: NetworkImage(comentarioEntity.perfil!)),
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                comentarioEntity.nome!,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              Text(
                comentarioEntity.message!,
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 15),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
