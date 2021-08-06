import 'package:flutter/material.dart';

class Comentarios extends StatelessWidget {
  String nome;
  String perfil;
  String texto;
  Comentarios(
    {required this.nome,
    required this.perfil,
    required this.texto}
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Row(
        children: [

        Padding(
          padding: const EdgeInsets.only(right: 16),
            child:  CircleAvatar(
                backgroundImage: NetworkImage(perfil.toString())),
            ),
        
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(nome.toString(),
                style: TextStyle(fontSize: 17,fontWeight: FontWeight.w500),
              ),
              Text(texto.toString(),
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 15),
              ),
            ],))

        ],
      ),
    );
  }
}