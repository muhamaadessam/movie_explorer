import 'package:dartz/dartz.dart';
import 'package:movie_explorer/core/error/exceptions.dart';
import 'package:movie_explorer/core/error/failure.dart';
import 'package:movie_explorer/core/network/movies_list_with_pagination.dart';
import 'package:movie_explorer/features/movies/data/datasource/movie_remote_data_source.dart';
import 'package:movie_explorer/features/movies/domain/entities/movie.dart';
import 'package:movie_explorer/features/movies/domain/repository/base_movies_repository.dart';
import 'package:movie_explorer/features/movies/domain/usecases/get_movie_details_usecase.dart';

class MoviesRepository extends BaseMoviesRepository {
  final BaseMovieRemoteDataSource baseMovieRemoteDataSource;

  MoviesRepository(this.baseMovieRemoteDataSource);

  @override
  Future<Either<Failure, MoviesListWithPaginationEntity>> getPopularMovies(
    parameters,
  ) async {
    final result = await baseMovieRemoteDataSource.getPopularMovies(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }

  @override
  Future<Either<Failure, Movie>> getMovieDetails(
    MovieDetailsParameters parameters,
  ) async {
    final result = await baseMovieRemoteDataSource.getMovieDetails(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
