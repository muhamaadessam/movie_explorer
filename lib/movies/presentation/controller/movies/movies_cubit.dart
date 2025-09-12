import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/enums.dart';
import '../../../domain/entities/movie.dart';
import '../../../domain/usecases/get_popular_movies_usecase.dart';

part 'movies_state.dart';

class MoviesCubit extends Cubit<MoviesState> {
  MoviesCubit(this.getPopularMoviesUseCase) : super(MoviesState());
  final GetPopularMoviesUseCase getPopularMoviesUseCase;
  int page = 1;

  getPopularMovies() async {
    emit(state.copyWith(popularState: RequestState.loading));
    final result = await getPopularMoviesUseCase(
      GetPopularMoviesParameters(page: page),
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          popularState: RequestState.error,
          popularMessage: l.message,
        ),
      ),
      (r) {
        var updatedMovies = [...state.popularMovies, ...r];
        emit(
          state.copyWith(
            popularState: RequestState.loaded,
            popularMovies: updatedMovies,
          ),
        );
        page++;
      },
    );
  }
}
