import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/custom_widgets/custom_scaffold.dart';
import '../../../../core/components/custom_widgets/error_screen.dart';
import '../../../../core/utils/enums.dart';
import '../../../movies/domain/entities/movie.dart';
import '../../../movies/presentation/components/movie_card.dart';
import '../../../movies/presentation/components/movie_card_shimmer.dart';
import '../controller/search_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<SearchCubit>().search(
          context.read<SearchCubit>().state.query,
        );
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
            case RequestState.loaded || RequestState.loading:
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 0.7,
                ),
                controller: _scrollController,
                itemCount:
                    state.status == RequestState.loading
                        ? (state.results.length + 4)
                        : state.results.length,
                itemBuilder: (context, index) {
                  if (index >= state.results.length) {
                    return const MovieCardShimmer();
                  }
                  final Movie movie = state.results[index];
                  return MovieCard(movie: movie);
                },
              );
            case RequestState.error:
              return ErrorScreen(
                message: state.searchMessage,
                onRetry: () => context.read<SearchCubit>().search(""),
              );
            case RequestState.init:
              return const Center(child: Text(""));
          }
        },
      ),
    );
  }
}
