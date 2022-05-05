import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:clean_architecture_cubit/injection_container.dart';
import 'package:clean_architecture_cubit/presentation/home/cubit/home_cubit.dart';
import 'package:clean_architecture_cubit/presentation/home/ui/movie_details_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static final _cacheManager = CacheManager(
    Config(
      'top_rated_movies_cache_key',
      stalePeriod: const Duration(seconds: 1),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(repository: sl()),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Top Rated Movies'),
              centerTitle: true,
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () => context.read<HomeCubit>().load(),
            //   child: const Icon(Icons.download),
            // ),
            body: state.maybeWhen(
              orElse: () {},
              initial: () => const Center(
                child: Text('Press Button To Load Movies'),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
              error: (message) => Center(
                child: Text(
                  message,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),
              laoded: (movies, currentPage) => LazyLoadScrollView(
                onEndOfPage: () {
                  log('${currentPage.runtimeType}: $currentPage');
                  context.read<HomeCubit>().loadMore(currentPage + 1);
                },
                child: Scrollbar(
                  child: ListView.separated(
                    // controller: scrollController,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
                    // itemCount: di.cubit.movie!.results!.length,
                    itemCount: movies.length,
                    separatorBuilder: (_, index) => const Divider(),
                    itemBuilder: (_, index) => GestureDetector(
                      onTap: () {
                        log(movies[index].id!.toString());
                        Get.to(
                          () => MovieDetailsPage(
                            movieId: movies[index].id!,
                          ),
                        );
                      },
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            cacheManager: _cacheManager,
                            imageUrl: 'http://image.tmdb.org/t/p/w500' +
                                movies[index].posterPath!,
                            width: 100,
                            height: 150,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const SizedBox(
                              width: 100,
                              height: 150,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 100,
                              height: 150,
                              color: Colors.grey.withOpacity(0.5),
                            ),

                            // maxHeightDiskCache: 75,
                          ),
                          // Image.network(
                          //   'http://image.tmdb.org/t/p/w500' +
                          //       movies[index].posterPath!,
                          //   width: MediaQuery.of(context).size.width * 0.3,
                          // ),
                          const SizedBox(
                            width: 10,
                          ),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  movies[index].title!,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      CupertinoIcons.star_fill,
                                      color: Colors.amber,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      movies[index].voteAverage.toString(),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                Text(
                                  movies[index].overview!,
                                  maxLines: 6,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
