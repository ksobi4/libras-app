// ignore_for_file: constant_identifier_names

import 'package:hive/hive.dart';
import 'package:libas_app/core/consts.dart';
import 'package:libas_app/core/errors/exceptions.dart';

const CASHED_TOKEN = 'CASHED_TOKEN';

class AuthLocalDataSrc {
  var box = Hive.box(Consts.HIVE_BOX_NAME);

  Future<String> getToken() async {
    try {
      final res = box.get(CASHED_TOKEN);
      if (res == null) {
        return "null";
      } else {
        return res;
      }
    } catch (e) {
      throw CacheException();
    }
  }

  Future<void> cacheToken(String token) async {
    box.put(CASHED_TOKEN, token);
  }

  Future<void> logOut() async {
    box.delete(CASHED_TOKEN);
  }
}
