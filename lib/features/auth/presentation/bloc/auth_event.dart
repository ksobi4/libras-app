part of 'auth_bloc.dart';

@freezed
abstract class AuthEvent with _$AuthEvent {
  const factory AuthEvent.logIn(String login, String password) = AuthLogInEvent;
  const factory AuthEvent.logOut() = AuthLogOutEvent;
  const factory AuthEvent.checkCachedToken() = AuthCheckCachedTokenEvent;
}
