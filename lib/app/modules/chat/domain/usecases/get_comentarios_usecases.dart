import 'package:dartz/dartz.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/entities/comentario_entity.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/repository/chat_repository.dart';

abstract class GetComentariosUsecases {
  Stream<List<ComentarioEntity>> call();
}

class GetComentariosUsecasesImpl implements GetComentariosUsecases {
  final ChatRepository repository;
  GetComentariosUsecasesImpl(this.repository);
  @override
  Stream<List<ComentarioEntity>> call() {
    return repository.getComentarios();
  }
}