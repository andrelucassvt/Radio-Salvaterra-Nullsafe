// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admob_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AdmobControllerBase on _AdmobControllerBase, Store {
  final _$interstitialAdAtom =
      Atom(name: '_AdmobControllerBase.interstitialAd');

  @override
  InterstitialAd get interstitialAd {
    _$interstitialAdAtom.reportRead();
    return super.interstitialAd;
  }

  @override
  set interstitialAd(InterstitialAd value) {
    _$interstitialAdAtom.reportWrite(value, super.interstitialAd, () {
      super.interstitialAd = value;
    });
  }

  final _$interstitialReadyAtom =
      Atom(name: '_AdmobControllerBase.interstitialReady');

  @override
  bool get interstitialReady {
    _$interstitialReadyAtom.reportRead();
    return super.interstitialReady;
  }

  @override
  set interstitialReady(bool value) {
    _$interstitialReadyAtom.reportWrite(value, super.interstitialReady, () {
      super.interstitialReady = value;
    });
  }

  final _$_AdmobControllerBaseActionController =
      ActionController(name: '_AdmobControllerBase');

  @override
  void createInterstitialAd() {
    final _$actionInfo = _$_AdmobControllerBaseActionController.startAction(
        name: '_AdmobControllerBase.createInterstitialAd');
    try {
      return super.createInterstitialAd();
    } finally {
      _$_AdmobControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
interstitialAd: ${interstitialAd},
interstitialReady: ${interstitialReady}
    ''';
  }
}
