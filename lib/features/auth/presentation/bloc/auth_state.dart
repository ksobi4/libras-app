part of 'auth_bloc.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.init() = AuthInit;
  const factory AuthState.loadingOUT() = AuthLoadingOut;
  const factory AuthState.loadingIN() = AuthLoadingIn;
  const factory AuthState.logIn(String token) = AuthLogIn;
  const factory AuthState.logOut() = AuthLogOut;
  factory AuthState.error(String message) = AuthError;

  const factory AuthState.waitingForCachedToken() = AuthWaitingForToken;
  const factory AuthState.loadedCachedToken(String token) = AuthLoadedToken;
}
