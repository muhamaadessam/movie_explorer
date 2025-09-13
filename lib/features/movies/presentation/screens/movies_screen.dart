import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/core/services/services_locator.dart';
import 'package:movie_explorer/core/themes/theme_cubit/app_theme_cubit.dart';
import 'package:movie_explorer/features/movies/presentation/controller/movies/movies_cubit.dart';

import '../../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../../core/components/custom_widgets/error_screen.dart';
import '../../../../core/utils/enums.dart';
import '../../../favorites/presentation/screens/favorites_screen.dart';
import '../../../movies/presentation/components/movie_card.dart';
import '../../../movies/presentation/components/movie_card_shimmer.dart';
import '../../../search/presentation/screens/search_screen.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => sl<MoviesCubit>()..getPopularMovies(),
      child: CustomScaffold(
        appBar: AppBar(
          title: const Text('Movie Explorer'),
          actions: [
            BlocBuilder<AppThemeCubit, AppThemeState>(
              builder: (context, state) {
                final themeCubit = context.read<AppThemeCubit>();
                return IconButton(
                  icon: Icon(
                    themeCubit.isDark ? Icons.light_mode : Icons.dark_mode,
                  ),
                  onPressed: () => themeCubit.toggleTheme(),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.favorite),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const FavoritesScreen(),
                  ),
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchScreen()),
                );
              },
            ),
          ],
        ),
        body: const MoviesContent(),
      ),
    );
  }
}

class MoviesContent extends StatefulWidget {
  const MoviesContent({super.key});

  @override
  State<MoviesContent> createState() => _MoviesContentState();
}

class _MoviesContentState extends State<MoviesContent> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<MoviesCubit>().getPopularMovies();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
              crossAxisCount: 2,
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
                  crossAxisCount: 2,
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
            return ErrorScreen(
              message: state.popularMessage,
              onRetry: () => context.read<MoviesCubit>().getPopularMovies(),
            );
          case RequestState.init:
            return const Center(child: Text("Popular movies"));
        }
      },
    );
  }
}
