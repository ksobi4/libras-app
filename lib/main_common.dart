// ignore_for_file: prefer_const_constructors, duplicate_ignore, constant_identifier_names

// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:libas_app/core/consts.dart';
import 'core/env/config_getter.dart';
import 'firebase_options.dart';

import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:libas_app/core/router.gr.dart';
import 'package:libas_app/core/theme.dart';
import 'package:libas_app/locator.dart';

import 'package:path_provider/path_provider.dart';

import 'features/grades/domain/grades.dart';

Future<void> mainCommon(String env) async {
  log('----------------------');
  WidgetsFlutterBinding.ensureInitialized();
  await locatorSetup();
  print('ENV = $env');

  //firebase testing part
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final fcmToken = await FirebaseMessaging.instance.getToken();

    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print(
            'Message also contained a notification: ${message.notification?.title}');
      }
    });

    print('fcmToken = $fcmToken');
  } catch (e) {
    print('notification err = $e');
  }
  //end firebase testing part

  //config import
  AppConfig config = await getAppConfig(env);

  print('baseUrl = ${config.baseUrl}');

  Provider configProvider = Provider<AppConfig>((ref) => config);

  //HIVE

  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(GradeAdapter());
  Hive.registerAdapter(TermAdapter());
  Hive.registerAdapter(SubjectAdapter());
  Hive.registerAdapter(GradesAdapter());

  await Hive.openBox(Consts.HIVE_BOX_NAME);

  await Firebase.initializeApp();
  FirebaseMessaging.onMessage.listen;

  print(' == ${Firebase.apps[0].name}');

  runApp(ProviderScope(child: AppWidget()));
}

class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    //notificationSetup();

    return MaterialApp.router(
      routerDelegate: _router.delegate(),
      routeInformationParser: _router.defaultRouteParser(),
      theme: appTheme,
      title: 'Material App',

      // home: SafeArea(child: GradesPage()),
    );
  }
}
