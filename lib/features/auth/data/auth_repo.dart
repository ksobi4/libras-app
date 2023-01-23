import 'package:dartz/dartz.dart';

import 'package:libas_app/core/errors/failures.dart';
import 'package:libas_app/core/network_info.dart';

import 'auth_local_data_src.dart';
import 'auth_remote_data_src.dart';

class AuthRepo {
  final AuthRemoteDataSrc remoteDataSrc;
  final AuthLocalDataSrc localDataSrc;
  final NetworkInfo networkInfo;

  AuthRepo({
    required this.remoteDataSrc,
    required this.localDataSrc,
    required this.networkInfo,
  });

  Future<Either<Failure, String>> logIn(String login, String password) async {
    String token = await localDataSrc.getToken();
    if (token == 'null') {
      try {
        token = await remoteDataSrc.logIn(login, password);
        await localDataSrc.cacheToken(token);
        return Right(token);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Right(token);
    }
  }

  Future<Either<Failure, String>> logOut() async {
    try {
      await localDataSrc.logOut();
      // ignore: void_checks
      return const Right('done');
    } catch (e) {
      return Left(CacheFailure());
    }
  }

  Future<Either<Failure, String>> checkToken() async {
    try {
      String token = await localDataSrc.getToken();
      return (token == 'null' ? const Right('null') : Right(token));
    } catch (e) {
      return Left(CacheFailure(message: 'error while getting cached token'));
    }
  }
}
