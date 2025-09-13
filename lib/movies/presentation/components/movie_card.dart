import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/movies/presentation/controller/favorites/favorites_cubit.dart';

import '../../../core/components/Shimmer/shimmer_widget.dart';
import '../../../core/network/Remote/api_constance.dart';
import '../../../core/utils/text_styels.dart';
import '../../../res/assets.dart';
import '../../data/models/movie_model.dart';
import '../../domain/entities/movie.dart';
import '../screens/movie_detail_screen.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({super.key, required this.movie, this.fromFavorites = false});

  final Movie movie;
  final bool fromFavorites;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(
                id: movie.id,
                movie: movie as MovieModel,
              ),
            ),
          );
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Hero(
                tag: 'movie_poster_${movie.id}',
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  child: CachedNetworkImage(
                    height: 300.0,
                    fit: BoxFit.cover,
                    imageUrl: ApiConstance.imageUrl(movie.posterImage),
                    placeholder: (context, url) =>
                        CustomShimmer(height: 170.0, width: 120.0),
                    errorWidget: (context, url, error) => Image.asset(
                      Assets.pngImagePlaceholder,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.transparent, Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 5,
              left: 0,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [TextBody14(movie.title, color: Colors.white)],
              ),
            ),
            if (movie.releaseDate != null)
              if (movie.releaseDate!.isNotEmpty)
                Positioned(
                  top: 10,
                  left: 5,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 2.0,
                      horizontal: 4.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red[800],
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextBody12(
                      movie.releaseDate!.split('-')[0],
                      color: Colors.white,
                    ),
                  ),
                ),
            if (fromFavorites)
              BlocBuilder<FavoritesCubit, FavoritesState>(
                builder: (context, state) {
                  return Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      icon: Icon(Icons.favorite, color: Colors.red[800]),
                      onPressed: () =>
                          context.read<FavoritesCubit>().toggleFavorite(
                            movie as MovieModel,
                          ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}