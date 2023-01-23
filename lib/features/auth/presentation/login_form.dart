// ignore: implementation_imports
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:libas_app/core/http_client.dart';
import 'package:libas_app/core/router.gr.dart';
import 'package:libas_app/features/auth/presentation/bloc/auth_bloc.dart';

import '../../../locator.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var formKey = GlobalKey<FormState>();

  String password = 'Julka4567', login = 'filip.ksobiak', error = '';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocProvider(
        create: (context) => sl.get<AuthBloc>(),
        child: Builder(
          builder: (context) {
            return BlocBuilder<AuthBloc, AuthState>(builder: (context, state) {
              if (state is AuthError) {
                Fluttertoast.showToast(msg: 'error: ${state.message}');
              }
              if (state is AuthLogIn) {
                sl.get<HttpClient>().setToken(state.token);
                Fluttertoast.showToast(msg: 'Zalogowano pomyślnie!');
                context.router.popAndPush(const GradesRoute());
              }

              return Form(
                  key: formKey,
                  child: Column(
                    children: [
                      const Text('Log in with Librus values'),
                      const SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        decoration: const InputDecoration(labelText: 'Login'),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => login = value,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a valid login!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => password = value,
                        obscureText: true,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter a valid password!';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                          onPressed: () => _submit(context),
                          child: const Text('Zaloguj się')),
                      Container(
                          child: state is AuthLoadingIn
                              ? const CircularProgressIndicator()
                              : null),
                    ],
                  ));
            });
          },
        ),
      ),
    );

    // return BlocProvider(
    //   create: (context) => sl.get<AuthBloc>(),
    //   child: BlocBuilder<AuthBloc, AuthState>(
    //     builder: (context, state) {
    //       if (state is AuthInit) return const Text('AuthInit');
    //       if (state is AuthLoadingIn) return const Text('AuthLoadingIn');
    //       if (state is AuthLoadingOut) return const Text('AuthLoadingOut');
    //       if (state is AuthLogIn) return const Text('AuthLogIn');
    //       if (state is AuthLogOut) {
    //         return const Text('AuthLogOut');
    //       } else {
    //         return const Text('dupa');
    //       }
    //     },
    //   ),
    // );
  }

  _submit(BuildContext context) {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }
    BlocProvider.of<AuthBloc>(context, listen: false)
        .add(AuthEvent.logIn(login, password));

    // setState(() {});
  }
}
