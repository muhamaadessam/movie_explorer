import 'package:dartz/dartz.dart';
import 'package:movie_explorer/core/error/failure.dart';
import 'package:movie_explorer/core/network/movies_list_with_pagination.dart';
import 'package:movie_explorer/features/movies/domain/entities/movie.dart';
import 'package:movie_explorer/features/movies/domain/usecases/get_movie_details_usecase.dart';

abstract class BaseMoviesRepository {
  Future<Either<Failure, MoviesListWithPaginationEntity>> getPopularMovies(
    parameters,
  );

  Future<Either<Failure, Movie>> getMovieDetails(
    MovieDetailsParameters parameters,
  );
}
