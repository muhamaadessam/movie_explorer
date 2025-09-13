import 'package:dartz/dartz.dart';
import 'package:movie_explorer/core/error/exceptions.dart';
import 'package:movie_explorer/core/error/failure.dart';
import 'package:movie_explorer/core/network/movies_list_with_pagination.dart';
import 'package:movie_explorer/features/search/domain/repository/base_search_repository.dart';

import '../../domain/usecases/search_movies_usecase.dart';
import '../datasource/movie_remote_data_source.dart';

class SearchRepository extends BaseSearchRepository {
  final BaseSearchRemoteDataSource baseMovieRemoteDataSource;

  SearchRepository(this.baseMovieRemoteDataSource);

  @override
  Future<Either<Failure, MoviesListWithPaginationEntity>> searchMovies(
    SearchMoviesParameters parameters,
  ) async {
    final result = await baseMovieRemoteDataSource.searchMovies(parameters);
    try {
      return Right(result);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.statusMessage));
    }
  }
}
