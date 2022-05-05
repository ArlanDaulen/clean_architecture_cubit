import 'dart:developer';

import 'package:clean_architecture_cubit/data/models/results_model.dart';
import 'package:clean_architecture_cubit/domain/entities/results.dart';
import 'package:hive/hive.dart';

abstract class LocalDataSource {
  Future<List<Results>>? getLastMovies();
  Future<void>? cacheMovies(List<Results> results);
}

const topRatedMoviesKey = 'top_rated_movies';

class LocalDataSourceImpl extends LocalDataSource {
  @override
  Future<void>? cacheMovies(List<Results> results) async {
    await Hive.openBox<Results>(topRatedMoviesKey);
    final box = Hive.box<Results>(topRatedMoviesKey);
    box.clear();
    for (var movie in results) {
      box.add(movie);
    }
    log('Movies saved');
    // Hive.close();
  }

  @override
  Future<List<Results>>? getLastMovies() async {
    await Hive.openBox<Results>(topRatedMoviesKey);

    return Hive.box<Results>(topRatedMoviesKey).values.toList().cast<Results>();
  }
}
