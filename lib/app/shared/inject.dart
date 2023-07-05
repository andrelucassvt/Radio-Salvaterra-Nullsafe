import 'package:audioplayers/audioplayers.dart';
import 'package:get_it/get_it.dart';
import 'package:radiosalvaterrafm/app/modules/chat/data/datasource/chat_datasource_impl.dart';
import 'package:radiosalvaterrafm/app/modules/chat/data/repository/chat_repository_impl.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/usecases/enviar_mensagem_usecases.dart';
import 'package:radiosalvaterrafm/app/modules/chat/domain/usecases/get_comentarios_usecases.dart';
import 'package:radiosalvaterrafm/app/modules/chat/presenter/stores/enviar_comentario/enviarcomentario_store.dart';
import 'package:radiosalvaterrafm/app/modules/chat/presenter/stores/get_comentarios/get_comentarios_store.dart';
import 'package:radiosalvaterrafm/app/modules/home/data/datasource/player_radio_datasource_impl.dart';
import 'package:radiosalvaterrafm/app/modules/home/data/repository/player_audio_repository_impl.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/usecases/get_player_audio.dart';
import 'package:radiosalvaterrafm/app/modules/home/presenter/store/playerbutton_store.dart';

class Inject {
  static Future<void> init() async {
    final getIt = GetIt.instance;

    getIt.registerFactory(() => AudioPlayer());
    getIt
        .registerFactory(() => PlayerAudioDatasourceImpl(getIt<AudioPlayer>()));

    getIt.registerFactory(
        () => PlayerAudioRepositoryImpl(getIt<PlayerAudioDatasourceImpl>()));
    getIt.registerFactory(
        () => GetPlayerUsecaseImpl(getIt<PlayerAudioRepositoryImpl>()));

    getIt.registerFactory(() => ChatDatasourceImpl());
    getIt
        .registerFactory(() => ChatRepositoryImpl(getIt<ChatDatasourceImpl>()));
    getIt.registerFactory(
        () => EnviarComentarioUsecasesImpl(getIt<ChatRepositoryImpl>()));
    getIt.registerFactory(
        () => GetComentariosUsecasesImpl(getIt<ChatRepositoryImpl>()));
    getIt.registerFactory(
        () => EnviarcomentarioStore(getIt<EnviarComentarioUsecasesImpl>()));

    getIt.registerSingleton(PlayerbuttonStore(getIt<GetPlayerUsecaseImpl>()));
    getIt.registerSingleton(
        GetComentariosStore(getIt<GetComentariosUsecasesImpl>()));
  }
}
