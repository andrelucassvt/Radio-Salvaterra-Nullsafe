import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:radiosalvaterrafm/app/modules/home/data/datasource/player_radio_datasource_impl.dart';
import 'package:radiosalvaterrafm/app/modules/home/data/repository/player_audio_repository_impl.dart';
import 'package:radiosalvaterrafm/app/modules/home/domain/usecases/get_player_audio.dart';
import 'package:radiosalvaterrafm/app/modules/home/presenter/store/playerbutton_store.dart';
import 'package:radiosalvaterrafm/app/modules/home/presenter/pages/home/home_page.dart';

class HomeModule extends WidgetModule {

  @override
  List<Bind<Object>> get binds => [
    Bind((i) => AudioPlayer()),
    Bind((i) => PlayerAudioDatasourceImpl(i<AudioPlayer>())),
    Bind((i) => PlayerAudioRepositoryImpl(i<PlayerAudioDatasourceImpl>())),
    Bind((i) => GetPlayerUsecaseImpl(i<PlayerAudioRepositoryImpl>())),
    Bind.singleton((i) => PlayerbuttonStore(i<GetPlayerUsecaseImpl>())),
  ];

  @override
  Widget get view => HomePage();
  
}