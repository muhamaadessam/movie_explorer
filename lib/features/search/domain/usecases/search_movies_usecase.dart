import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_explorer/core/error/failure.dart';
import 'package:movie_explorer/core/network/movies_list_with_pagination.dart';
import 'package:movie_explorer/core/usecase/base_usecase.dart';

import '../repository/base_search_repository.dart';

class SearchMoviesUseCase
    extends
        BaseUseCase<MoviesListWithPaginationEntity, SearchMoviesParameters> {
  final BaseSearchRepository baseSearchRepository;

  SearchMoviesUseCase(this.baseSearchRepository);

  @override
  Future<Either<Failure, MoviesListWithPaginationEntity>> call(
    SearchMoviesParameters parameters,
  ) async {
    return await baseSearchRepository.searchMovies(parameters);
  }
}

class SearchMoviesParameters extends Equatable {
  final String query;
  final int page;

  const SearchMoviesParameters({required this.query, required this.page});

  @override
  List<Object?> get props => [query, page];
}
