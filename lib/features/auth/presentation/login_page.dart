// ignore_for_file: constant_identifier_names

import 'dart:developer';

// ignore: implementation_imports
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:libas_app/core/consts.dart';
import 'package:libas_app/core/http_client.dart';
import 'package:libas_app/core/router.gr.dart';
import 'package:libas_app/features/auth/presentation/login_form.dart';
import 'package:uuid/uuid.dart';

import '../../../locator.dart';
import 'bloc/auth_bloc.dart';

const NOTIFICATION_DEVICE_ID = 'NOTIFICATION_DEVICE_ID';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: BlocProvider.value(
            value: sl<AuthBloc>()..add(const AuthEvent.checkCachedToken()),
            child: Builder(
              builder: (context) {
                return BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                  if (state is AuthLoadedToken) {
                    if (state.token == 'null') {
                      return const LoginForm();
                    } else {
                      log('pobralem token i pomijam logowanie ${state.token}');
                      sl.get<HttpClient>().setToken(state.token);
                      context.router.replace(const GradesRoute());
                      return const Text('');
                    }
                  } else {
                    return const CircularProgressIndicator();
                  }
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
