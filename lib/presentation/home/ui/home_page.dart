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
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static final _cacheManager = CacheManager(
    Config(
      'top_rated_movies_cache_key',
      stalePeriod: const Duration(seconds: 1),
    ),
  );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int page = 1;

  nextPage() {
    setState(() {
      page++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(repository: sl()),
      child: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: const Color(0xff032541),
              title: const Text('Top Rated Movies'),
              centerTitle: true,
            ),
            // floatingActionButton: FloatingActionButton(
            //   onPressed: () => context.read<HomeCubit>().load(),
            //   child: const Icon(Icons.download),
            // ),
            body: state.maybeWhen(
              orElse: () {
                return null;
              },
              loading: () => ListView.separated(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 20,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                separatorBuilder: (_, index) => const SizedBox(
                  height: 15,
                ),
                itemBuilder: (_, index) => SizedBox(
                  width: double.maxFinite,
                  height: 150,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        child: Container(
                          color: Colors.white,
                          width: 100,
                          height: 150,
                        ),
                        baseColor: Colors.grey.shade300,
                        highlightColor: Colors.grey.shade100,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Shimmer.fromColors(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                width: double.maxFinite,
                                height: 20,
                              ),
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Shimmer.fromColors(
                              child: Container(
                                width: 60,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              baseColor: Colors.grey.shade300,
                              highlightColor: Colors.grey.shade100,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: Shimmer.fromColors(
                                child: Container(
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
              laoded: (movies) => LazyLoadScrollView(
                onEndOfPage: () {
                  nextPage();
                  context.read<HomeCubit>().loadMore(page);
                },
                child: CupertinoScrollbar(
                  child: ListView.separated(
                    // controller: scrollController,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(
                      vertical: 15,
                      horizontal: 20,
                    ),
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
                            cacheManager: HomePage._cacheManager,
                            imageUrl: 'http://image.tmdb.org/t/p/w500' +
                                movies[index].posterPath!,
                            width: 100,
                            height: 150,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(
                              child: Shimmer.fromColors(
                                child: Container(
                                  color: Colors.white,
                                  width: 100,
                                  height: 150,
                                ),
                                baseColor: Colors.grey.shade300,
                                highlightColor: Colors.grey.shade100,
                              ),
                            ),
                            errorWidget: (context, url, error) => Container(
                              width: 100,
                              height: 150,
                              color: Colors.grey.withOpacity(0.5),
                            ),
                          ),
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
