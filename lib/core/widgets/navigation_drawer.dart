// ignore: implementation_imports
import 'dart:developer';

// ignore: implementation_imports
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:fluttertoast/fluttertoast.dart';

import 'package:libas_app/core/router.gr.dart';
import 'package:libas_app/features/auth/presentation/bloc/auth_bloc.dart';

import '../../locator.dart';

// ignore: must_be_immutable
class NavigationDrawer extends StatelessWidget {
  String headerName = '';

  NavigationDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<AuthBloc>(),
      child: Builder(
        builder: (context) {
          return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
            if (state is AuthError) {
              Fluttertoast.showToast(msg: 'Nie udało się wylogować :(');
              log('log out faile');
              // return Text('');
            }
            if (state is AuthLogOut) {
              log('log out complete');
              Fluttertoast.showToast(msg: 'Wylogowano pomyślnie!');
              context.router.replace(const LoginRoute());
              // return Text('');
            }
            if (state is AuthLoadingOut) {
              log('log out progress');
              return const CircularProgressIndicator();
            }

            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: Drawer(
                child: Material(
                  color: Colors.grey[700],
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: ListView(children: [
                          const Divider(color: Colors.white70),
                          _buildHeader(),
                          const Divider(color: Colors.white70),
                          _buildMenuItem(
                              text: 'Oceny',
                              icon: Icons.filter_5,
                              onClicked: () => _selectItem(context, 1)),
                          _buildMenuItem(
                              text: 'Test',
                              icon: Icons.filter_5,
                              onClicked: () => _selectItem(context, 2)),
                        ]),
                      ),
                      _buildMenuItem(
                          text: 'Log out',
                          icon: Icons.logout,
                          onClicked: () => _submit(context))
                    ],
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }

  Widget _buildHeader() {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            const CircleAvatar(radius: 10),
            const SizedBox(width: 20),
            Text(headerName),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.grey[300];

    return Center(
      child: ListTile(
        leading: Icon(icon, color: color),
        title: Text(text),
        onTap: onClicked,
      ),
    );
  }

  void _selectItem(BuildContext context, int index) {
    switch (index) {
      case 1:
        context.router.replace(const GradesRoute());
        break;
      case 2:
        context.router.replace(const TestRoute());
        break;
    }
    Navigator.pop(context);
  }

  void setName(String name) {
    headerName = name;
  }
}

_submit(BuildContext context) {
  BlocProvider.of<AuthBloc>(context, listen: false)
      .add(const AuthEvent.logOut());
}
