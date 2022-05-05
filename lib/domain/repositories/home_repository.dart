import 'package:clean_architecture_cubit/core/error/failures.dart';
import 'package:clean_architecture_cubit/domain/entities/movie.dart';
import 'package:clean_architecture_cubit/domain/entities/movie_details.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, Movie>>? getTopRatedMovies(int page);
  Future<Either<Failure, MovieDetails>>? getMovieDetails(int movieId);
}
