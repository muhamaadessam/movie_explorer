import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/core/extensions/context_extension.dart';
import 'package:movie_explorer/core/services/services_locator.dart';
import 'package:movie_explorer/core/themes/theme_cubit/app_theme_cubit.dart';
import 'package:movie_explorer/movies/presentation/components/popular_component.dart';
import 'package:movie_explorer/movies/presentation/controller/movies/movies_cubit.dart';
import 'package:movie_explorer/movies/presentation/screens/search_screen.dart';

import '../../../core/components/custom_widgets/custom_scaffold.dart';
import 'favorites_screen.dart';

class MoviesScreen extends StatelessWidget {
  const MoviesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>
      sl<MoviesCubit>()
        ..getPopularMovies(),
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
        body: const PopularComponent(),
      ),
    );
  }
}
