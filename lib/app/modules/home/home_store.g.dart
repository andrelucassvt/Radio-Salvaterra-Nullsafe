// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on HomeStoreBase, Store {
  final _$audioPlayerAtom = Atom(name: 'HomeStoreBase.audioPlayer');

  @override
  AudioPlayer get audioPlayer {
    _$audioPlayerAtom.reportRead();
    return super.audioPlayer;
  }

  @override
  set audioPlayer(AudioPlayer value) {
    _$audioPlayerAtom.reportWrite(value, super.audioPlayer, () {
      super.audioPlayer = value;
    });
  }

  final _$interstitialAdAtom = Atom(name: 'HomeStoreBase.interstitialAd');

  @override
  InterstitialAd? get interstitialAd {
    _$interstitialAdAtom.reportRead();
    return super.interstitialAd;
  }

  @override
  set interstitialAd(InterstitialAd? value) {
    _$interstitialAdAtom.reportWrite(value, super.interstitialAd, () {
      super.interstitialAd = value;
    });
  }

  final _$handlePressedAsyncAction = AsyncAction('HomeStoreBase.handlePressed');

  @override
  Future<dynamic> handlePressed() {
    return _$handlePressedAsyncAction.run(() => super.handlePressed());
  }

  final _$createInterstitialAdAsyncAction =
      AsyncAction('HomeStoreBase.createInterstitialAd');

  @override
  Future<void> createInterstitialAd() {
    return _$createInterstitialAdAsyncAction
        .run(() => super.createInterstitialAd());
  }

  @override
  String toString() {
    return '''
audioPlayer: ${audioPlayer},
interstitialAd: ${interstitialAd}
    ''';
  }
}
