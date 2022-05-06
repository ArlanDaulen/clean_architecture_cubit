import 'package:clean_architecture_cubit/core/error/exceptions.dart';
import 'package:clean_architecture_cubit/core/network/network_info.dart';
import 'package:clean_architecture_cubit/data/datasources/local_datasource.dart';
import 'package:clean_architecture_cubit/data/datasources/remote_datasource.dart';
import 'package:clean_architecture_cubit/domain/entities/movie_details.dart';
import 'package:clean_architecture_cubit/core/error/failures.dart';
import 'package:clean_architecture_cubit/domain/entities/results.dart';
import 'package:clean_architecture_cubit/domain/repositories/home_repository.dart';
import 'package:dartz/dartz.dart';

const String noInternet = 'No Internet Connection';

class HomeRepositoryImpl implements HomeRepository {
  final RemoteDataSource remoteDataSource;
  final LocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  HomeRepositoryImpl({
    required this.networkInfo,
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, MovieDetails>>? getMovieDetails(int movieId) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMovie = await remoteDataSource.getMovieDetails(movieId);
        return Right(remoteMovie!);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(e.message),
        );
      }
    } else {
      return Left(
        ServerFailure(noInternet),
      );
    }
  }

  @override
  Future<Either<Failure, List<Results>>>? getTopRatedMovies(int page) async {
    if (await networkInfo.isConnected) {
      try {
        final remoteMovie = await remoteDataSource.getTopRatedMovies(page);
        List<Results> results = remoteMovie!.results!;
        localDataSource.cacheMovies(results);
        final movies = await localDataSource.getLastMovies();
        return Right(movies!);
      } on ServerException catch (e) {
        return Left(
          ServerFailure(e.message),
        );
      }
    } else {
      try {
        final localMovie = await localDataSource.getLastMovies();
        // Hive.close();
        return Right(localMovie!);
      } on CacheException {
        return Left(
          CacheFailure(
            'Unexpected error in loading cached movies',
          ),
        );
      }
      // return Left(
      //   ServerFailure(noInternet),
      // );
    }
  }
}
