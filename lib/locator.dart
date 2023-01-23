import 'package:get_it/get_it.dart';
import 'package:libas_app/core/http_client.dart';
import 'package:libas_app/core/network_info.dart';
import 'package:libas_app/features/auth/data/auth_repo.dart';
import 'package:libas_app/features/grades/data/grades_local_data_src.dart';
import 'package:libas_app/features/grades/data/grades_remote_data_src.dart';
import 'package:libas_app/features/grades/data/grades_repository.dart';
import 'package:libas_app/features/grades/presentation/bloc/grades_bloc.dart';

import 'features/auth/data/auth_local_data_src.dart';
import 'features/auth/data/auth_remote_data_src.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> locatorSetup() async {
  //Blocs
  sl.registerFactory<GradesBloc>(() => GradesBloc(gradesRepository: sl()));
  sl.registerFactory<AuthBloc>(() => AuthBloc(authRepo: sl()));

  //Repositoryies
  sl.registerLazySingleton<GradesRepository>(() => GradesRepository(
      remoteDataSrc: sl(), localDataSrc: sl(), networkInfo: sl()));

  sl.registerLazySingleton<AuthRepo>(() =>
      AuthRepo(remoteDataSrc: sl(), localDataSrc: sl(), networkInfo: sl()));

  //Data srcs
  sl.registerLazySingleton<GradesRemoteDataSrc>(
      () => GradesRemoteDataSrc(client: sl()));
  sl.registerLazySingleton<GradesLocalDataSrc>(() => GradesLocalDataSrc());

  sl.registerLazySingleton<AuthRemoteDataSrc>(
      () => AuthRemoteDataSrc(client: sl()));
  sl.registerLazySingleton<AuthLocalDataSrc>(() => AuthLocalDataSrc());

  //another
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfo());

  sl.registerLazySingleton<HttpClient>(() => HttpClient());

  //widgets

  // sl.registerLazySingleton<NavigationDrawer>(() => NavigationDrawer());
}
