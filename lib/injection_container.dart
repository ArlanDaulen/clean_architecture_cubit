import 'package:clean_architecture_cubit/core/network/network_info.dart';
import 'package:clean_architecture_cubit/data/datasources/local_datasource.dart';
import 'package:clean_architecture_cubit/data/datasources/remote_datasource.dart';
import 'package:clean_architecture_cubit/data/repositories/home_repository_impl.dart';
import 'package:clean_architecture_cubit/domain/repositories/home_repository.dart';
import 'package:clean_architecture_cubit/presentation/home/cubit/home_cubit.dart';
import 'package:clean_architecture_cubit/presentation/home/cubit/movie_details_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubits
  // sl.registerFactory(() => HomeCubit(repository: sl()));
  // sl.registerLazySingleton(() => MovieDetailsCubit(repository: sl()));

  // Repositories
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      networkInfo: sl(),
      localDataSource: sl(),
      remoteDataSource: sl(),
    ),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  // Datasources
  sl.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
