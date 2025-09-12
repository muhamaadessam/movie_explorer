import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/enums.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/search_movies_usecase.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.searchMoviesUseCase) : super(const SearchState());
  final SearchMoviesUseCase searchMoviesUseCase;
  Timer? _debounce;

  search(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 600), () async {
      if (query.isEmpty) {
        emit(state.copyWith(status: RequestState.init, results: []));
        return;
      }

      emit(state.copyWith(status: RequestState.loading));
      final result = await searchMoviesUseCase(
        SearchMoviesParameters(query: query),
      );
      result.fold(
        (failure) {
          emit(state.copyWith(status: RequestState.error));
        },
        (movies) {
          print("==>search $movies");
          emit(state.copyWith(status: RequestState.loaded, results: movies));
        },
      );
    });
  }
}
