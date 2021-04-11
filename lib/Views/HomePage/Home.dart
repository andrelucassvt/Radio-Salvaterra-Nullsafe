import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobx/mobx.dart';
import 'package:radiosalvaterrafm/Animation/WaveWidget.dart';
import 'package:radiosalvaterrafm/Util/Global.dart';
import 'package:radiosalvaterrafm/Util/views/atualizacao.dart';
import 'package:radiosalvaterrafm/Util/controller/controller.dart';
import 'package:radiosalvaterrafm/Views/Info/info.dart';
import 'package:url_launcher/url_launcher.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  InterstitialAd _interstitialAd;
  bool _interstitialReady = false;

  static final AdRequest request = AdRequest(
    testDevices: <String>[],
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    nonPersonalizedAds: true,
  );
  void createInterstitialAd() {
    _interstitialAd = InterstitialAd(
      adUnitId: 'ca-app-pub-3652623512305285/7857500684',
      request: request,
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('${ad.runtimeType} loaded.');
          _interstitialReady = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('${ad.runtimeType} failed to load: $error.');
          ad.dispose();
          _interstitialAd = null;
          createInterstitialAd();
        },
        onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
        onAdClosed: (Ad ad) {
          print('${ad.runtimeType} closed.');
          ad.dispose();
          createInterstitialAd();
        },
        onApplicationExit: (Ad ad) =>
            print('${ad.runtimeType} onApplicationExit.'),
      ),
    )..load();
  }
  final _controller = Controller();
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      _pegarAtt();
      MobileAds.instance.initialize().then((InitializationStatus status) {
        print('Initialization done: ${status.adapterStatuses}');
        MobileAds.instance
            .updateRequestConfiguration(RequestConfiguration(
                tagForChildDirectedTreatment:
                    TagForChildDirectedTreatment.unspecified))
            .then((void value) {
          createInterstitialAd();
        });
      });
    }
  @override
  void dispose() {
    _interstitialAd.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showCupertinoModalPopup(
            context: context,
            builder: (x)=>Horarios());
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
                    Colors.amber
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
                color: Global.white,
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
                  Container(
                    height: 60,
                    width: 150,
                    child: ElevatedButton.icon(
                      onPressed: (){
                        _interstitialAd.show();
                        _controller.playMusic();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.green,
                            duration: Duration(seconds: 10),
                            content: Text('Conectando ao servidor'),
                          )
                        );
                      },
                      icon: Icon(Icons.play_arrow),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue
                      ),
                      label: Flexible(
                        child: AutoSizeText(
                          'Reproduzir',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 20
                          ),
                          ),
                      ),
                    )
                  ),
                  Container(
                    height: 60,
                    width: 150,
                    child: ElevatedButton.icon(
                      onPressed: (){
                        _controller.pauseMusic();
                      },
                      icon: Icon(Icons.pause),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red
                      ),
                      label: Flexible(
                        child: AutoSizeText(
                          'Parar',
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 20
                          ),
                          ),
                      ),
                    )
                  ),

                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  _pegarAtt()async{
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('status').doc('att').get();
     Map<String, dynamic> data = snapshot.data();
      if (data['atualizar'] != Global.atualizacao){
        Future.delayed(Duration.zero,(){
          showCupertinoModalPopup(
            context: context,
            builder: (x)=>AtualizarApp());
        });
      }
  }
}