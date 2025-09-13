import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_explorer/core/error/failure.dart';
import 'package:movie_explorer/core/usecase/base_usecase.dart';
import 'package:movie_explorer/movies/data/models/movie_model.dart';
import 'package:movie_explorer/movies/domain/entities/movie.dart';
import 'package:movie_explorer/movies/domain/repository/base_movies_repository.dart';

class SearchMoviesUseCase
    extends BaseUseCase<ResponseEntity, SearchMoviesParameters> {
  final BaseMoviesRepository baseMoviesRepository;

  SearchMoviesUseCase(this.baseMoviesRepository);

  @override
  Future<Either<Failure, ResponseEntity>> call(
    SearchMoviesParameters parameters,
  ) async {
    return await baseMoviesRepository.searchMovies(parameters);
  }
}

class SearchMoviesParameters extends Equatable {
  final String query;
  final int page;

  const SearchMoviesParameters({required this.query, required this.page});

  @override
  List<Object?> get props => [query, page];
}

class ResponseEntity extends Equatable {
  final int page;
  final int totalPages;
  final List<Movie> results;

  const ResponseEntity({
    required this.page,
    required this.totalPages,
    required this.results,
  });

  @override
  List<Object?> get props => [page, totalPages, results];
}

class ResponseModel extends ResponseEntity {
  const ResponseModel({
    required super.page,
    required super.totalPages,
    required super.results,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => ResponseModel(
    page: json["page"],
    totalPages: json["total_pages"],
    results: List<Movie>.from(json["results"].map((x) => MovieModel.fromJson(x))),
  );
}
