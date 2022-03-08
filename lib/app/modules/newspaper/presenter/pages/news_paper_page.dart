import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class NewsPaperPage extends StatefulWidget {

  @override
  State<NewsPaperPage> createState() => _NewsPaperPageState();
}

class _NewsPaperPageState extends State<NewsPaperPage> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double loadingValue = 0.0;
  AdWidget adWidget;
  final BannerAd myBanner = BannerAd(
    adUnitId: 'ca-app-pub-3652623512305285/8485046406',
    size: AdSize.banner,
    request: AdRequest(),
    listener: BannerAdListener(),
  );
  @override
  void initState() {
    super.initState();
    myBanner.load();
    adWidget = AdWidget(ad: myBanner);
    flutterWebViewPlugin.onProgressChanged.listen((event) { 
      setState(() {
        loadingValue = event;
      });
    });
  }
  @override
  void dispose() {
    myBanner.dispose();
    flutterWebViewPlugin.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      key: widget.key,
      url: 'https://noticiamarajo.com.br/ultimas-noticias/',
      withZoom: true,
      withLocalStorage: true,
      mediaPlaybackRequiresUserGesture: false,
      debuggingEnabled: false,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          alignment: Alignment.center,
          child: adWidget,
          width: myBanner.size.width.toDouble(),
          height: myBanner.size.height.toDouble(),
        )
      ),
      appBar: AppBar(
        //automaticallyImplyLeading: false,
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
          preferredSize: const Size.fromHeight(1.0),
          child: LinearProgressIndicator(
            value: loadingValue
          ),
        ),
      ),
    );
  }
}