import 'package:equatable/equatable.dart';

class Movie extends Equatable {
  final int id;
  final String title;
  final String posterImage;
  final String overview;
  final double voteAverage;
  final String? releaseDate;
  final int totalPages;

  const Movie({
    required this.id,
    required this.title,
    required this.posterImage,
    required this.overview,
    required this.voteAverage,
    required this.releaseDate,
    required this.totalPages,
  });

  @override
  List<Object> get props => [
    id,
    title,
    posterImage,
    overview,
    voteAverage,
    releaseDate!,
    totalPages,
  ];
}
