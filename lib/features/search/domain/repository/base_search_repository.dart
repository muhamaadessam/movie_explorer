import 'package:dartz/dartz.dart';
import 'package:movie_explorer/core/error/failure.dart';
import 'package:movie_explorer/core/network/movies_list_with_pagination.dart';

import '../usecases/search_movies_usecase.dart';

abstract class BaseSearchRepository {
  Future<Either<Failure, MoviesListWithPaginationEntity>> searchMovies(
    SearchMoviesParameters parameters,
  );
}
