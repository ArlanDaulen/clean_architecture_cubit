import 'package:clean_architecture_cubit/domain/entities/results.dart';
import 'package:clean_architecture_cubit/domain/repositories/home_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'home_state.dart';
part 'home_cubit.freezed.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepository repository;

  // List<Results> movieList = [];

  HomeCubit({required this.repository}) : super(const HomeState.initial()) {
    init();
  }

  @override
  Future<void> close() {
    Hive.close();
    return super.close();
  }

  void init() async {
    emit(const HomeState.loading());
    loadMore(1);
  }

  void loadMore(int page) async {
    final failureOrMovies = await repository.getTopRatedMovies(page);
    failureOrMovies!.fold(
      (failure) => emit(HomeState.error(failure.message)),
      (movies) => emit(HomeState.laoded(movies)),
    );
  }
}
