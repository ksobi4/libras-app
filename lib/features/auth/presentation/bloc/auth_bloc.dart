import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:libas_app/core/errors/failures.dart';
import 'package:libas_app/features/auth/data/auth_repo.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo authRepo;

  AuthBloc({required this.authRepo}) : super(const AuthState.init()) {
    on<AuthLogInEvent>(_onLogIn);
    on<AuthLogOutEvent>(_onLogOut);
    on<AuthCheckCachedTokenEvent>(_onCheckToken);
  }

  Future<void> _onLogIn(AuthLogInEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loadingIN());

    Either<Failure, String> failureOrString =
        await authRepo.logIn(event.login, event.password);

    emit(_eitherAuthLogInOrAuthError(failureOrString));
  }

  AuthState _eitherAuthLogInOrAuthError(
      Either<Failure, String> failureOrString) {
    return failureOrString.fold(
      (failure) {
        if (failure is CacheFailure) {
          return AuthState.error('CACHE ERR mess ');
        } else if (failure is ServerFailure) {
          return AuthState.error('SERVER ERR mess: ${failure.message}');
        } else {
          return AuthState.error('jakis error');
        }
      },
      (token) {
        return AuthState.logIn(token);
      },
    );
  }

  Future<void> _onLogOut(AuthLogOutEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.loadingOUT());

    Either<Failure, String> failureOrString = await authRepo.logOut();

    emit(_eitherAuthLogOutOrAuthError(failureOrString));
  }

  AuthState _eitherAuthLogOutOrAuthError(
      Either<Failure, String> failureOrString) {
    return failureOrString.fold((failure) {
      if (failure is CacheFailure) {
        return AuthState.error('CACHE ERR mess ');
      } else if (failure is ServerFailure) {
        return AuthState.error('SERVER ERR mess');
      } else {
        return AuthState.error('jakis error');
      }
    }, (status) => const AuthState.logOut());
  }

  FutureOr<void> _onCheckToken(
      AuthCheckCachedTokenEvent event, Emitter<AuthState> emit) async {
    emit(const AuthState.waitingForCachedToken());

    Either<Failure, String> failureOrString = await authRepo.checkToken();

    emit(_eitherStringOrError(failureOrString));
  }

  AuthState _eitherStringOrError(Either<Failure, String> failureOrString) {
    return failureOrString.fold((failure) {
      if (failure is CacheFailure) {
        return AuthState.error('CACHE ERR mess ');
      } else if (failure is ServerFailure) {
        return AuthState.error('SERVER ERR mess');
      } else {
        return AuthState.error('jakis error');
      }
    }, (token) => AuthState.loadedCachedToken(token));
  }
}
