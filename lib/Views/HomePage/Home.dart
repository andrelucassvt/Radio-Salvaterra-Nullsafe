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
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-3652623512305285/6823768348',
    size: AdSize.banner,
    request: AdRequest(),
    listener: AdListener(),
  );
  final AdListener listener = AdListener(
    // Called when an ad is successfully received.
    onAdLoaded: (Ad ad) => print('Ad loaded.'),
    // Called when an ad request failed.
    onAdFailedToLoad: (Ad ad, LoadAdError error) {
      ad.dispose();
      print('Ad failed to load: $error');
    },
    // Called when an ad opens an overlay that covers the screen.
    onAdOpened: (Ad ad) => print('Ad opened.'),
    // Called when an ad removes an overlay that covers the screen.
    onAdClosed: (Ad ad) => print('Ad closed.'),
    // Called when an ad is in the process of leaving the application.
    onApplicationExit: (Ad ad) => print('Left application.'),
  );

  @override
    void initState() {
      // TODO: implement initState
      super.initState();
      myInterstitial.load();
      myBanner.load();
      adWidget = AdWidget(ad: myBanner);
    }
  AdWidget adWidget;  
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
            child: Container(
              child: adWidget,
              width: 500,
              height: 500,
            ),
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
                        FlutterRadio.playOrPause(url: Global.streamUrl);
                        myInterstitial.show();
                        Scaffold.of(context)
                          .showSnackBar(SnackBar(
                              duration: Duration(seconds: 7),
                              backgroundColor: Colors.green,
                              content: Text("Conectando ao servidor",style: TextStyle(color: Colors.white),
                          )));
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
                        FlutterRadio.stop();
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
}