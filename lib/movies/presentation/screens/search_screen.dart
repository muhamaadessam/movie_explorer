import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../core/utils/enums.dart';
import '../../domain/entities/movie.dart';
import '../components/movie_card.dart';
import '../controller/search/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: TextField(
          autofocus: true,
          decoration: const InputDecoration(
            hintText: "Search movies...",
            border: InputBorder.none,
          ),
          onChanged: (value) {
            context.read<SearchCubit>().search(value);
          },
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          switch (state.status) {
            case RequestState.loading:
              return const Center(child: CircularProgressIndicator());
            case RequestState.loaded:
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 0.7,
                ),
                itemCount: state.results.length,
                itemBuilder: (context, index) {
                  final Movie movie = state.results[index];
                  return MovieCard(movie: movie);
                },
              );
            case RequestState.error:
              return const Center(child: Text("Failed to load results"));
            case RequestState.init:
              return const Center(child: Text(""));
          }
        },
      ),
    );
  }
}
