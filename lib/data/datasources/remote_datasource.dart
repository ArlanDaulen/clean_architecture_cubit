import 'dart:convert';
import 'dart:developer';

import 'package:clean_architecture_cubit/core/error/exceptions.dart';
import 'package:clean_architecture_cubit/core/error/helper.dart';
import 'package:clean_architecture_cubit/data/models/movie_details_model.dart';
import 'package:clean_architecture_cubit/data/models/movie_model.dart';
import 'package:clean_architecture_cubit/shared/dialogs/error_dialog.dart';
import 'package:http/http.dart' as http;

abstract class RemoteDataSource {
  Future<MovieModel>? getTopRatedMovies(int page);
  Future<MovieDetailsModel>? getMovieDetails(int movieId);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final http.Client client;
  RemoteDataSourceImpl({required this.client});

  final headers = {'Content-Type': 'application/json'};

  @override
  Future<MovieModel>? getTopRatedMovies(int page) async {
    final response = await client.get(
      Uri.parse(
          'https://api.themoviedb.org/3/movie/top_rated?api_key=7b79568d4e94ac70052f8e960cc7aa12&language=en-US&page=$page'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      log(response.statusCode.toString());
      log((MovieModel.fromJson(json.decode(response.body)).results == null)
          .toString());
      return MovieModel.fromJson(json.decode(response.body));
    } else {
      log(response.statusCode.toString());
      throw ServerException(
        message: Helper.handleError(
          response.statusCode,
          json.decode(response.body)['status_message'],
        ),
      );
    }
  }

  @override
  Future<MovieDetailsModel>? getMovieDetails(int movieId) async {
    final response = await client.get(
      Uri.parse(
        'https://api.themoviedb.org/3/movie/$movieId?api_key=7b79568d4e94ac70052f8e960cc7aa12&language=en-US',
      ),
      headers: headers,
    );
    if (response.statusCode == 200) {
      log(response.statusCode.toString());
      return MovieDetailsModel.fromJson(
        json.decode(response.body),
      );
    } else {
      log(response.statusCode.toString());
      throw ServerException(
          message: json.decode(response.body)['status_message']);
    }
  }
}
