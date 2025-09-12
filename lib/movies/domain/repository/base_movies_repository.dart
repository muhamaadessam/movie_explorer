import 'package:dartz/dartz.dart';
import 'package:movie_explorer/core/error/failure.dart';
import 'package:movie_explorer/movies/domain/entities/movie.dart';
import 'package:movie_explorer/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:movie_explorer/movies/domain/usecases/search_movies_usecase.dart';

abstract class BaseMoviesRepository {
  Future<Either<Failure, List<Movie>>> getPopularMovies(parameters);

  Future<Either<Failure, Movie>> getMovieDetails(
    MovieDetailsParameters parameters,
  );

  Future<Either<Failure, List<Movie>>> searchMovies(
    SearchMoviesParameters parameters,
  );
}
