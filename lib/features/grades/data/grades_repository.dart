import 'package:libas_app/core/errors/exceptions.dart';
import 'package:libas_app/core/errors/failures.dart';
import 'package:libas_app/core/network_info.dart';
import 'package:libas_app/features/grades/data/grades_local_data_src.dart';
import 'package:libas_app/features/grades/data/grades_remote_data_src.dart';
import 'package:libas_app/features/grades/domain/grades.dart';
import 'package:dartz/dartz.dart';

class GradesRepository {
  final GradesRemoteDataSrc remoteDataSrc;
  final GradesLocalDataSrc localDataSrc;
  final NetworkInfo networkInfo;

  GradesRepository({
    required this.remoteDataSrc,
    required this.localDataSrc,
    required this.networkInfo,
  });

  Future<Either<Failure, Grades>> getGrades() async {
    if (await networkInfo.isConnected) {
      try {
        Grades data = await remoteDataSrc.getGrades();

        Grades dataToCache = data;
        dataToCache.isCachedData = true;
        await localDataSrc.cacheGrades(dataToCache);

        return Right(data);
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      try {
        Grades data = await localDataSrc.getGrades();
        return Right(data);
      } on CacheException catch (e) {
        return Left(CacheFailure(message: e.toString()));
      }
    }
  }

  Future<Either<Failure, Grade>> getOneGrade(String gradeId) async {
    if (await networkInfo.isConnected) {
      try {
        Grade data = await remoteDataSrc.getOneGrade(gradeId);

        Grade dataToCache = data;
        dataToCache.isCachedData = true;
        await localDataSrc.cacheOneGrade(dataToCache);

        return Right(data);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        Grade data = await localDataSrc.getOneGrade(gradeId);
        return Right(data);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
