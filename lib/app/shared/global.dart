import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HelperGlobal {
  static const Color white = const Color(0xffffffff);
  static const streamUrl = "https://s13.maxcast.com.br:8725/live";

  static Future<double> version() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String code = packageInfo.buildNumber;
    return double.parse(code);
  }
}
