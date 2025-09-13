import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/core/services/services_locator.dart';

import '../../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../../core/components/custom_widgets/error_screen.dart';
import '../../../movies/presentation/components/movie_card.dart';
import '../controller/favorites_cubit.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FavoritesCubit>()..loadFavorites(),
      child: CustomScaffold(
        appBar: AppBar(title: const Text("Favorites")),
        body: BlocBuilder<FavoritesCubit, FavoritesState>(
          builder: (context, state) {
            if (state.status == FavoritesStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.status == FavoritesStatus.failure) {
              return ErrorScreen(
                message: state.favoritesMessage,
                onRetry: () {
                  context.read<FavoritesCubit>().loadFavorites();
                },
              );
            }
            if (state.favorites.isEmpty) {
              return const Center(child: Text("No favorites yet"));
            }
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
                childAspectRatio: 0.7,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                final movie = state.favorites[index];
                return MovieCard(movie: movie, fromFavorites: true);
              },
            );
          },
        ),
      ),
    );
  }
}
