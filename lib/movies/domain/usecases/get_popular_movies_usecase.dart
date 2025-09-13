import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_explorer/core/error/failure.dart';
import 'package:movie_explorer/core/usecase/base_usecase.dart';
import 'package:movie_explorer/movies/domain/entities/movie.dart';
import 'package:movie_explorer/movies/domain/repository/base_movies_repository.dart';
import 'package:movie_explorer/movies/domain/usecases/search_movies_usecase.dart';

class GetPopularMoviesUseCase
    extends BaseUseCase<ResponseEntity, GetPopularMoviesParameters> {
  final BaseMoviesRepository baseMoviesRepository;

  GetPopularMoviesUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, ResponseEntity>> call(
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
