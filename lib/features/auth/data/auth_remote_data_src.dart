import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:libas_app/core/errors/exceptions.dart';
import 'package:libas_app/core/http_client.dart';
import 'package:libas_app/core/consts.dart' as consts;
import 'package:firebase_messaging/firebase_messaging.dart';

// ignore: constant_identifier_names

class AuthRemoteDataSrc {
  HttpClient client;
  AuthRemoteDataSrc({
    required this.client,
  });

  Future<String> logIn(login, password) async {
    try {
      Response res = await client.dio.post('/login', data: {
        'login': login,
        'password': password,
        'notification_token': await getNotificationToken()
      });

      if (res.statusCode == 200) {
        return res.data['token'];
      } else {
        print('bad output = ${res.data}');
        throw ServerException(messaage: 'Wprowadzono błędne dane');
      }
    } catch (e) {
      log('LOGIN ERR = ${e.toString()}');
      throw e.toString();
    }
  }
}

getNotificationToken() async {
  // var box = Hive.box(config.hiveBoxName);
  // return box.get(consts.NOTIFICATION_DEVICE_ID);
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('notif token = ${fcmToken}');
  return fcmToken;
}
