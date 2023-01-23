// ignore_for_file: prefer_const_declarations, prefer_const_constructors

import 'dart:developer';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:libas_app/core/widgets/navigation_drawer.dart';

import 'features/grades/domain/grades.dart';
import 'features/grades/presentation/bloc/grades_bloc.dart';
// import 'package:onesignal_flutter/onesignal_flutter.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    super.initState();

    //Remove this method to stop OneSignal Debugging
    // OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);

    //dobre->
    // OneSignal.shared.setAppId("6d3f563a-a0ab-4391-9d69-f91a3c2250cf");

    // // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt. We recommend removing the following code and instead using an In-App Message to prompt for notification permission
    // OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    //   log("Accepted permission: $accepted");
    // });

    // var externalUserId =
    //     '123456789'; // You will supply the external user id to the OneSignal SDK
    // log('KURWA');
    // // Setting External User Id with Callback Available in SDK Version 3.9.3+
    // OneSignal.shared.setExternalUserId(externalUserId).then((results) {
    //   log('MY GOOD 1' + results.toString());
    // }).catchError((error) {
    //   log('MY ERROR 1' + error.toString());
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      appBar: AppBar(),
      body: Builder(builder: (context) {
        return Center(
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text('open drawer'),
              ),
              ElevatedButton(
                  onPressed: () async {
                    Map<String, dynamic> jsonData = jsonDecode(
                        await rootBundle.loadString('assets/file.json'));
                    Grades tempG = Grades.fromJson(jsonData);
                    log('end');
                  },
                  child: Text('test btn')),
            ],
          ),
        );
      }),
    );
  }
}
