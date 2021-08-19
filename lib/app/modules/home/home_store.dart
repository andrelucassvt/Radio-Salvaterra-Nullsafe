import 'package:audioplayers/audioplayers.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:mobx/mobx.dart';
import 'package:radiosalvaterrafm/app/shared/global.dart';

part 'home_store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  @observable
  AudioPlayer audioPlayer;

  HomeStoreBase(this.audioPlayer);

  static final AdRequest request = AdRequest(
      keywords: <String>['flutterio', 'beautiful apps'],
      contentUrl: 'https://flutter.io',
      nonPersonalizedAds: true,
    );

  @observable
  InterstitialAd? interstitialAd;

  @action
  Future handlePressed() async {
    switch (audioPlayer.state) {
      case PlayerState.COMPLETED:
      case PlayerState.STOPPED:
        audioPlayer.setUrl(Global.streamUrl);
        audioPlayer.resume();
        break;

      case PlayerState.PAUSED:
        audioPlayer.resume();
        break;

      case PlayerState.PLAYING:
        audioPlayer.stop();
        break;
    }
  }

  @action
  Future<void> createInterstitialAd() async {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3652623512305285/7857500684', 
      request: request, 
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (InterstitialAd ad){
          interstitialAd = ad;
        }, 
        onAdFailedToLoad: (LoadAdError error){
          print('InterstitialAd failed to load: $error');
        }
      )
    );
  }
}