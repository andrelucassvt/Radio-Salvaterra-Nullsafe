import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_radio/flutter_radio.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:radiosalvaterrafm/Animation/WaveWidget.dart';
import 'package:radiosalvaterrafm/Util/Global.dart';
import 'package:radiosalvaterrafm/Views/Info/info.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool play = false;
  final InterstitialAd myInterstitial = InterstitialAd(
    adUnitId: 'ca-app-pub-3652623512305285/7857500684',
    request: AdRequest(),
    listener: AdListener(),
  );
  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      myInterstitial.load();
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
                        setState((){
                          audioPlay();            
                        });
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
                        setState(() {
                          if(play == true){
                            FlutterRadio.stop();
                            play = false;
                          }else{
                            print('Nada');
                          }                                                              
                        });
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

  audioPlay()async{
    if(play == false){
      myInterstitial.show();
      await FlutterRadio.audioStart();
      FlutterRadio.play(url: Global.streamUrl);
      Scaffold.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 7),
          backgroundColor: Colors.green,
          content: Text("Conectando ao servidor",style: TextStyle(color: Colors.white),
      )));
      play = true;
    }else {
      FlutterRadio.pause(url: Global.streamUrl);
      play = false;
    }
  }
}