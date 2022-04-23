import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NewsPaperPage extends StatefulWidget {

  @override
  State<NewsPaperPage> createState() => _NewsPaperPageState();
}

class _NewsPaperPageState extends State<NewsPaperPage> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  double loadingValue = 0.0;
  InterstitialAd _interstitialAd;
  _carregarAd(){
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3652623512305285/1073212828',
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
  @override
  void initState() {
    super.initState();
    _carregarAd();
    Future.delayed(Duration(seconds: 60),(){
     _interstitialAd.show();
    });
    flutterWebViewPlugin.onProgressChanged.listen((event) { 
      setState(() {
        loadingValue = event;
      });
    });
  }
  @override
  void dispose() {
    flutterWebViewPlugin.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      key: widget.key,
      url: 'https://extradopara.com/category/salvaterra/',
      withZoom: true,
      withLocalStorage: true,
      mediaPlaybackRequiresUserGesture: false,
      debuggingEnabled: false,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.red,
        title: Text(
          'Marajó News',
          maxLines: 1,
          style: TextStyle(
            fontSize: 20
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.autorenew),
            onPressed: () {
              flutterWebViewPlugin.reload();
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(10.0),
          child: LinearProgressIndicator(
            value: loadingValue
          ),
        ),
      ),
    );
  }
}