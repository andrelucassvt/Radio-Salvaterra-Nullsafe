import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'get_comentarios_state.dart';

class GetComentariosStore extends ValueNotifier<GetComentariosState> {
  GetComentariosStore() : super(GetComentariosInitial());
}
