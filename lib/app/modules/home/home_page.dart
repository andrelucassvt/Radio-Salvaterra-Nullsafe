import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:radiosalvaterrafm/app/modules/home/animation/wave_widget.dart';
import 'package:radiosalvaterrafm/app/modules/home/home_module.dart';
import 'package:radiosalvaterrafm/app/modules/home/home_store.dart';
import 'package:radiosalvaterrafm/app/modules/info/info_module.dart';
import 'package:radiosalvaterrafm/app/modules/info/info_page.dart';
import 'package:radiosalvaterrafm/app/shared/global.dart';
import 'package:radiosalvaterrafm/app/shared/views/atualizar_app.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage,HomeStore> {
  @override
  void initState() {
    super.initState();
    _pegarAtt();
    MobileAds.instance.initialize().then((value) {
      controller.createInterstitialAd();
    });
  }
  @override
  void dispose() {
    controller.interstitialAd?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final bool keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    return WillPopScope(
      onWillPop: () async => false, 
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            showCupertinoModalPopup(
              context: context,
              builder: (x) => InfoModule());
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
                        onPressed: () async {
                          controller.handlePressed();
                          await controller.interstitialAd?.show();
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
                          controller.handlePressed();
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
      ),
    );
  }
  _pegarAtt()async{
    DocumentSnapshot<Map<String,dynamic>> snapshot = await FirebaseFirestore.instance.collection('status').doc('att').get();
     Map<String, dynamic> data = snapshot.data()!;
      if (data['atualizar'] != Global.atualizacao){
        Future.delayed(Duration.zero,(){
          showCupertinoModalPopup(
            context: context,
            builder: (x)=>AtualizarApp());
        });
      }
  }
}