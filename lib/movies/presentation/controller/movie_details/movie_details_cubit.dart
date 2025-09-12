import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_explorer/movies/domain/entities/movie.dart';

import '../../../../core/utils/enums.dart';
import '../../../domain/usecases/get_movie_details_usecase.dart';

part 'movie_details_state.dart';

class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit(this.getMovieDetailsUseCase) : super(MovieDetailsState());
  final GetMovieDetailsUseCase getMovieDetailsUseCase;

  getMovieDetails(int movieId) async {
    emit(state.copyWith(movieDetailsState: RequestState.loading));
    final result = await getMovieDetailsUseCase(
      MovieDetailsParameters(movieId: movieId),
    );
    result.fold(
      (l) => emit(
        state.copyWith(
          movieDetailsState: RequestState.error,
          movieDetailsMessage: l.message,
        ),
      ),
      (r) => emit(
        state.copyWith(movieDetail: r, movieDetailsState: RequestState.loaded),
      ),
    );
  }
}
