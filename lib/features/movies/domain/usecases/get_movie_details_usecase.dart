import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_explorer/core/error/failure.dart';
import 'package:movie_explorer/core/usecase/base_usecase.dart';
import 'package:movie_explorer/features/movies/domain/repository/base_movies_repository.dart';

import '../entities/movie.dart';

class GetMovieDetailsUseCase
    extends BaseUseCase<Movie, MovieDetailsParameters> {
  final BaseMoviesRepository baseMoviesRepository;

  GetMovieDetailsUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, Movie>> call(MovieDetailsParameters parameters) async {
    return await baseMoviesRepository.getMovieDetails(parameters);
  }
}

class MovieDetailsParameters extends Equatable {
  final int movieId;

  const MovieDetailsParameters({required this.movieId});

  @override
  List<Object> get props => [movieId];
}
