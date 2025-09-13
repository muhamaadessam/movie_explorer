import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/enums.dart';
import '../../../movies/domain/entities/movie.dart';
import '../../domain/usecases/search_movies_usecase.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchMoviesUseCase) : super(const SearchState());
  final SearchMoviesUseCase searchMoviesUseCase;
  Timer? _debounce;

  int page = 1;
  int totalPages = 2;

  search(String query) {
    if (page > totalPages) return;
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 600), () async {
      if (query.isEmpty) {
        emit(state.copyWith(status: RequestState.init, results: []));
        return;
      }

      emit(state.copyWith(status: RequestState.loading, query: query));
      final result = await searchMoviesUseCase(
        SearchMoviesParameters(query: query, page: page),
      );
      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: RequestState.error,
              searchMessage: failure.message,
            ),
          );
        },
        (movies) {
          List<Movie> current = [...state.results, ...movies.results];
          totalPages = movies.totalPages;
          emit(state.copyWith(status: RequestState.loaded, results: current));
          page++;
        },
      );
    });
  }
}
