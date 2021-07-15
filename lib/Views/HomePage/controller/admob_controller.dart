import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobx/mobx.dart';
part 'admob_controller.g.dart';


class AdmobControllerBase = _AdmobControllerBase with _$AdmobControllerBase;

abstract class _AdmobControllerBase with Store {

  static final AdRequest request = AdRequest(
    testDevices: <String>[],
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    nonPersonalizedAds: true,
  );

  @observable
  InterstitialAd interstitialAd;
  
  @observable
  bool interstitialReady = false;

  @action
  void createInterstitialAd() {
    interstitialAd = InterstitialAd(
      adUnitId: 'ca-app-pub-3652623512305285/7857500684',
      request: request,
      listener: AdListener(
        onAdLoaded: (Ad ad) {
          print('${ad.runtimeType} loaded.');
          interstitialReady = true;
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('${ad.runtimeType} failed to load: $error.');
          ad.dispose();
          interstitialAd = null;
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
}