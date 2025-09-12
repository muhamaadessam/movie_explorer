import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/core/utils/enums.dart';

import '../controller/movies/movies_cubit.dart';
import 'movie_card.dart';
import 'movie_card_shimmer.dart';

class PopularComponent extends StatefulWidget {
  const PopularComponent({super.key});

  @override
  State<PopularComponent> createState() => _PopularComponentState();
}

class _PopularComponentState extends State<PopularComponent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    print("initState");
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        print("object");
        context.read<MoviesCubit>().getPopularMovies();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, MoviesState>(
      buildWhen:
          (previous, current) => previous.popularState != current.popularState,
      builder: (context, state) {
        if (state.popularMovies.isEmpty) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.7,
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: 20,
            itemBuilder: (context, index) {
              return const MovieCardShimmer();
            },
          );
        }
        switch (state.popularState) {
          case RequestState.loaded || RequestState.loading:
            return FadeIn(
              duration: const Duration(milliseconds: 500),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 0.7,
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    state.popularState == RequestState.loading
                        ? (state.popularMovies.length + 4)
                        : state.popularMovies.length,
                itemBuilder: (context, index) {
                  if (index >= state.popularMovies.length) {
                    return const MovieCardShimmer();
                  }
                  final movie = state.popularMovies[index];
                  return MovieCard(movie: movie);
                },
              ),
            );
          case RequestState.error:
            return SizedBox(
              height: 170.0,
              child: Center(child: Text(state.popularMessage)),
            );
          case RequestState.init:
            return const Center(child: Text("Popular movies"));
        }
      },
    );
  }
}
