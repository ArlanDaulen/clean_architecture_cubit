import 'dart:developer';

import 'package:clean_architecture_cubit/domain/entities/movie.dart';
import 'package:clean_architecture_cubit/domain/entities/results.dart';
import 'package:clean_architecture_cubit/domain/repositories/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  List<Results> movieList = [];

  HomeCubit({required this.repository}) : super(const HomeState.initial()) {
    init();
  }

  void init() async {
    emit(const HomeState.loading());
    final failureOrMovies = await repository.getTopRatedMovies(1);
    failureOrMovies!.fold(
      (failure) => emit(HomeState.error(failure.message)),
      (movies) {
        movieList.addAll(movies.results!);
        emit(HomeState.laoded(movieList, movies.page!));
        // movies.page => count
      },
    );
  }

  void loadMore(int page) async {
    final failureOrMovies = await repository.getTopRatedMovies(page);
    failureOrMovies!.fold(
      (failure) => emit(HomeState.error(failure.message)),
      (movies) {
        log(movieList.length.toString());
        movieList.addAll(movies.results!);
        emit(HomeState.laoded(movieList, movies.page!));
      },
    );
  }
}
