import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  String baseUrl;

  AppConfig({
    required this.baseUrl,
  });
}

Future<AppConfig> getAppConfig(String env) async {
  final _configString = await rootBundle.loadString('assets/$env.json');
  Map<String, dynamic> _config =
      await json.decode(_configString) as Map<String, dynamic>;

  return AppConfig(
    baseUrl: _config["baseUrl"],
  );
}



// abstract class ConfigGetter {
//   static Map<String, dynamic> _config;

//   static Future<void> initialize() async {
//     final configString = await rootBundle.loadString('config/app_config.json');
//     _config = json.decode(configString) as Map<String, dynamic>;
//   }

//   static int getIncrementAmount() {
//     return _config['incrementAmount'] as int;
//   }

//   static String getSecretKey() {
//     return _config['secretKey'] as String;
//   }
// }
