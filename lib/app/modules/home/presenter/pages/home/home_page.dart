import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:radiosalvaterrafm/app/modules/home/presenter/animation/wave_widget.dart';
import 'package:radiosalvaterrafm/app/modules/home/presenter/pages/info/info_page.dart';
import 'package:radiosalvaterrafm/app/modules/home/presenter/store/player_button/player_store.dart';
import 'package:radiosalvaterrafm/app/modules/home/presenter/widgets/button_player.dart';
import 'package:radiosalvaterrafm/app/shared/global.dart';
import 'package:radiosalvaterrafm/app/shared/views/atualizar_app.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  InterstitialAd _interstitialAd;
  final controller = Modular.get<PlayerStore>();

  @override
  void initState() {
    super.initState();
    _pegarAtt();
    _carregarAd();
    Future.delayed(Duration(seconds: 15),(){
     //_interstitialAd.show();
    });
  }
  
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return WillPopScope(
      onWillPop: () async => false, 
      child: Scaffold(
        backgroundColor: Colors.red,
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showCupertinoModalPopup(
              context: context,
              builder: (x) => InfoPage(),
            );
          },
          backgroundColor: Colors.green,
          child: Icon(Icons.info),
        ),
        body: Stack(
          children: [
              Container(
                height: size.height - 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red,
                      Colors.yellow,
                    ]
                  )
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.easeOutQuad,
                top: keyboardOpen ? -size.height / 3.7 : 0.0,
                child: WaveWidget(
                  size: size,
                  yOffset: size.height / 2.2,
                  color: HelperGlobal.white,
                ),
              ),
            Padding(
              padding: const EdgeInsets.only(top: 25),
              child: Image.asset('Imagens/Salvaterra.png'),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: controller,
                      builder: (context,value,child) {
                        return BottonPlayerWidget(
                          isButtonPause: false,
                          isProgress: value,
                          pauseOrPlayerFunction: () async => controller.playerAudio(context),
                        );
                      }
                    ),
                    BottonPlayerWidget(
                      pauseOrPlayerFunction: () async => controller.playerAudioPause(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  _pegarAtt() async {
    double codeBuilder = await HelperGlobal.version();
    DocumentSnapshot<Map<String,dynamic>> snapshot = await FirebaseFirestore.instance.collection('status').doc('att').get();
    Map<String, dynamic> data = snapshot.data();
    if (data['build'] > codeBuilder) {
      Future.delayed(Duration.zero,(){
        showCupertinoModalPopup(
          context: context,
          builder: (x) => AtualizarApp());
      });
    }
  }

  _carregarAd(){
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3652623512305285/1543293215',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad) {
          setState(() {
            this._interstitialAd = ad;
          });
        },
        onAdFailedToLoad: (LoadAdError error) {
          print('InterstitialAd failed to load: $error');
        },
      ));
    }
}