import 'package:equatable/equatable.dart';

import '../../features/movies/data/models/movie_model.dart';
import '../../features/movies/domain/entities/movie.dart';

class MoviesListWithPaginationEntity extends Equatable {
  final int page;
  final int totalPages;
  final List<Movie> results;

  const MoviesListWithPaginationEntity({
    required this.page,
    required this.totalPages,
    required this.results,
  });

  @override
  List<Object?> get props => [page, totalPages, results];
}

class MoviesListWithPaginationModel extends MoviesListWithPaginationEntity {
  const MoviesListWithPaginationModel({
    required super.page,
    required super.totalPages,
    required super.results,
  });

  factory MoviesListWithPaginationModel.fromJson(Map<String, dynamic> json) =>
      MoviesListWithPaginationModel(
        page: json["page"],
        totalPages: json["total_pages"],
        results: List<Movie>.from(
          json["results"].map((x) => MovieModel.fromJson(x)),
        ),
      );
}
