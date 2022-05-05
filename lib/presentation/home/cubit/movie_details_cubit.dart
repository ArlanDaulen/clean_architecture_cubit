import 'dart:developer';

import 'package:clean_architecture_cubit/domain/entities/movie_details.dart';
import 'package:clean_architecture_cubit/domain/repositories/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'movie_details_state.dart';
part 'movie_details_cubit.freezed.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  final HomeRepository repository;
  MovieDetailsCubit({required this.repository})
      : super(const MovieDetailsState.initial());

  void load(int movieId) async {
    emit(const MovieDetailsState.loading());
    final failureOrMovieDetails = await repository.getMovieDetails(movieId);
    failureOrMovieDetails!.fold(
      (failure) => emit(MovieDetailsState.error(failure.message)),
      (movieDetails) => emit(MovieDetailsState.loaded(movieDetails)),
    );
  }
}
