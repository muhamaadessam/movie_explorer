import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_explorer/core/error/failure.dart';
import 'package:movie_explorer/core/network/movies_list_with_pagination.dart';
import 'package:movie_explorer/core/usecase/base_usecase.dart';
import 'package:movie_explorer/features/movies/domain/repository/base_movies_repository.dart';

class GetPopularMoviesUseCase
    extends
        BaseUseCase<
          MoviesListWithPaginationEntity,
          GetPopularMoviesParameters
        > {
  final BaseMoviesRepository baseMoviesRepository;

  GetPopularMoviesUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, MoviesListWithPaginationEntity>> call(
    GetPopularMoviesParameters parameters,
  ) async {
    return await baseMoviesRepository.getPopularMovies(parameters);
  }
}

class GetPopularMoviesParameters extends Equatable {
  final int page;

  const GetPopularMoviesParameters({required this.page});

  @override
  List<Object?> get props => [page];
}
