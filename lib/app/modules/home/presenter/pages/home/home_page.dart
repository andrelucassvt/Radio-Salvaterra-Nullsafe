import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:radiosalvaterrafm/app/modules/home/presenter/pages/info/info_page.dart';
import 'package:radiosalvaterrafm/app/modules/home/presenter/store/playerbutton_store.dart';
import 'package:radiosalvaterrafm/app/modules/home/presenter/widgets/button_player.dart';
import 'package:radiosalvaterrafm/app/shared/global.dart';
import 'package:radiosalvaterrafm/app/shared/views/atualizar_app.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final playerButtonCubit = GetIt.instance.get<PlayerbuttonStore>();
  final BannerAd myBanner = BannerAd(
    adUnitId: Platform.isAndroid
        ? 'ca-app-pub-3652623512305285/8485046406'
        : 'ca-app-pub-3652623512305285/8125489410',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );
  late AdWidget adWidget;
  @override
  void initState() {
    super.initState();
    _pegarAtt();
    myBanner.load();
    adWidget = AdWidget(ad: myBanner);
    playerButtonCubit.addListener(() {
      final value = playerButtonCubit.value;
      if (value is PlayerbuttonLoading) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Conectando ao servidor"),
          duration: Duration(seconds: 5),
          backgroundColor: Colors.blue,
        ));
      }
      if (value is PlayerbuttonFailure) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(value.error.message),
          backgroundColor: Colors.red,
        ));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        //backgroundColor: Colors.red,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showCupertinoModalPopup(
              context: context,
              builder: (x) => InfoPage(),
            );
          },
          backgroundColor: Colors.green,
          child: Icon(Icons.info),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 60),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Colors.red,
                  Colors.yellow,
                ])),
                child: Image.asset('Imagens/Salvaterra.png'),
              ),
              SizedBox(
                height: 170,
              ),
              Container(
                alignment: Alignment.center,
                color: Colors.white,
                child: adWidget,
                width: myBanner.size.width.toDouble(),
                height: myBanner.size.height.toDouble(),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ValueListenableBuilder<PlayerbuttonState>(
                        valueListenable: playerButtonCubit,
                        builder: (context, value, child) {
                          return BottonPlayerWidget(
                            isButtonPause: false,
                            isProgress: value is PlayerbuttonLoading,
                            pauseOrPlayerFunction: () async =>
                                playerButtonCubit.playerAudio(),
                          );
                        }),
                    BottonPlayerWidget(
                      pauseOrPlayerFunction: () async =>
                          playerButtonCubit.playerAudioPause(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _pegarAtt() async {
    double codeBuilder = await HelperGlobal.version();
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('status').doc('att').get();
    Map<String, dynamic> data = snapshot.data() ?? {};
    if (data['build'] > codeBuilder) {
      Future.delayed(Duration.zero, () {
        showCupertinoModalPopup(
            context: context, builder: (x) => AtualizarApp());
      });
    }
  }
}
