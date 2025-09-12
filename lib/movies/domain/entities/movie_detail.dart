import 'package:equatable/equatable.dart';

class MovieDetail extends Equatable {
  final String posterImage;
  final int id;
  final String overview;
  final String releaseDate;
  final int runtime;
  final String title;
  final double voteAverage;

  const MovieDetail({
    required this.posterImage,
    required this.id,
    required this.overview,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
  });

  @override
  List<Object> get props => [
    posterImage,
    id,
    overview,
    releaseDate,
    runtime,
    title,
    voteAverage,
  ];
}
