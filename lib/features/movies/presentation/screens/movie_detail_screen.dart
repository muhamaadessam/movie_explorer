import 'package:animate_do/animate_do.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/core/network/Remote/api_constance.dart';
import 'package:movie_explorer/core/services/services_locator.dart';
import 'package:movie_explorer/core/utils/enums.dart';
import 'package:movie_explorer/features/movies/presentation/controller/movie_details/movie_details_cubit.dart';

import '../../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../../core/components/custom_widgets/error_screen.dart';
import '../../../../core/themes/theme_cubit/app_theme_cubit.dart';
import '../../../../core/utils/text_styels.dart';
import '../../../favorites/presentation/controller/favorites_cubit.dart';
import '../../data/models/movie_model.dart';

class MovieDetailScreen extends StatelessWidget {
  final int id;
  final MovieModel movie;

  const MovieDetailScreen({super.key, required this.id, required this.movie});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<MovieDetailsCubit>()..getMovieDetails(id),
      lazy: false,
      child: CustomScaffold(body: MovieDetailContent(movie: movie, id: id)),
    );
  }
}

class MovieDetailContent extends StatelessWidget {
  const MovieDetailContent({super.key, required this.movie, required this.id});

  final MovieModel movie;
  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
      builder: (context, state) {
        switch (state.movieDetailsState) {
          case RequestState.loading:
            return Column(
              children: [
                // Show Hero animation even while loading
                Hero(
                  tag: 'movie_poster_${movie.id}',
                  child: SizedBox(
                    height: 500,
                    width: double.infinity,
                    child: CachedNetworkImage(
                      imageUrl: ApiConstance.imageUrl(movie.posterImage),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                ),
              ],
            );
          case RequestState.loaded:
            return CustomScrollView(
              key: const Key('movieDetailScrollView'),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  expandedHeight: 500.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Hero(
                      tag: 'movie_poster_${movie.id}',
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black,
                              Colors.black,
                              Colors.transparent,
                            ],
                            stops: [0.0, 0.5, 1.0, 1.0],
                          ).createShader(
                            Rect.fromLTRB(0.0, 0.0, rect.width, rect.height),
                          );
                        },
                        blendMode: BlendMode.dstIn,
                        child: CachedNetworkImage(
                          width: MediaQuery.of(context).size.width,
                          imageUrl: ApiConstance.imageUrl(
                            state.movieDetail!.posterImage,
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: FadeInUp(
                    from: 20,
                    duration: const Duration(milliseconds: 500),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: TextTitle(state.movieDetail!.title),
                              ),
                              BlocBuilder<FavoritesCubit, FavoritesState>(
                                builder: (context, state) {
                                  final cubit = context.read<FavoritesCubit>();
                                  return IconButton(
                                    onPressed: () {
                                      context
                                          .read<FavoritesCubit>()
                                          .toggleFavorite(movie);
                                    },
                                    icon: Icon(
                                      Icons.favorite,
                                      color:
                                          cubit.isFavorite(movie.id)
                                              ? Colors.red
                                              : null,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            children: [
                              if (state.movieDetail!.releaseDate != null)
                                if (movie.releaseDate!.isNotEmpty)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 2.0,
                                      horizontal: 8.0,
                                    ),
                                    decoration: BoxDecoration(
                                      color:
                                          context
                                              .read<AppThemeCubit>()
                                              .containerColor,
                                      borderRadius: BorderRadius.circular(4.0),
                                    ),
                                    child: TextBody12(
                                      state.movieDetail!.releaseDate!.split(
                                        '-',
                                      )[0],
                                    ),
                                  ),
                              const SizedBox(width: 16.0),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 20.0,
                                  ),
                                  const SizedBox(width: 4.0),
                                  Text(
                                    state.movieDetail!.voteAverage
                                        .toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            state.movieDetail!.overview,
                            style: const TextStyle(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          case RequestState.error:
            return ErrorScreen(
              message: state.movieDetailsMessage,
              onRetry:
                  () => context.read<MovieDetailsCubit>().getMovieDetails(id),
            );
          case RequestState.init:
            return const Center(child: Text("Type to search movies"));
        }
      },
    );
  }
}
