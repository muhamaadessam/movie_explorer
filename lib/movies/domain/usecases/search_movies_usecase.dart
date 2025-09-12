import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_explorer/core/error/failure.dart';
import 'package:movie_explorer/core/usecase/base_usecase.dart';
import 'package:movie_explorer/movies/domain/entities/movie.dart';
import 'package:movie_explorer/movies/domain/repository/base_movies_repository.dart';

class SearchMoviesUseCase
    extends BaseUseCase<List<Movie>, SearchMoviesParameters> {
  final BaseMoviesRepository baseMoviesRepository;

  SearchMoviesUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, List<Movie>>> call(
    SearchMoviesParameters parameters,
  ) async {
    return await baseMoviesRepository.searchMovies(parameters);
  }
}

class SearchMoviesParameters extends Equatable {
  final String query;

  const SearchMoviesParameters({required this.query});

  @override
  List<Object?> get props => [query];
}
