import 'package:clean_architecture_cubit/data/models/results_model.dart';
import 'package:clean_architecture_cubit/domain/entities/movie.dart';

import '../../domain/entities/results.dart';

class MovieModel extends Movie {
  MovieModel({
    required int page,
    required List<ResultsModel> results,
    required int totalPages,
    required int totalResults,
  }) : super(
          page: page,
          results: results,
          totalPages: totalPages,
          totalResults: totalResults,
        );

  MovieModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(ResultsModel.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['page'] = page;
    data['results'] = results;
    data['totalPages'] = totalPages;
    data['totalResults'] = totalResults;
    return data;
  }
}
