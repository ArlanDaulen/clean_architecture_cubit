import 'dart:developer';

import 'package:clean_architecture_cubit/injection_container.dart';
import 'package:clean_architecture_cubit/presentation/home/cubit/movie_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MovieDetailsPage extends StatelessWidget {
  const MovieDetailsPage({Key? key, required this.movieId}) : super(key: key);
  final int movieId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MovieDetailsCubit(repository: sl())..load(movieId),
      child: BlocConsumer<MovieDetailsCubit, MovieDetailsState>(
        listener: (context, state) {},
        builder: (context, state) => Scaffold(
          appBar: AppBar(
            title: Text(
              state.when(
                initial: () => 'Movie Details',
                loading: () => 'Loading...',
                loaded: (movieDetails) => movieDetails.title!,
                error: (message) => 'Something went wrong',
              ),
            ),
            centerTitle: true,
          ),
          body: state.when(
            initial: () => const Center(
              child: Text('Movie details will show here'),
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            loaded: (movieDetails) => Center(
              child: Column(
                children: [
                  Text(movieDetails.title!),
                  ...List.generate(
                    movieDetails.genres!.length,
                    (index) => Text(movieDetails.genres![index].name!),
                  ),
                  Text(
                    movieDetails.budget.toString(),
                  ),
                  Text(movieDetails.releaseDate!),
                ],
              ),
            ),
            error: (message) => Center(
              child: Text(
                message,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
