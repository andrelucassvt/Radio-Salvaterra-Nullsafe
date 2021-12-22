import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HelperGlobal {
  static const Color white = const Color(0xffffffff);
  static const streamUrl =
      "https://s10.maxcast.com.br:8234/live";

  static const String atualizacao = '6';

  static Future<String> version() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    return version;
  }
} 