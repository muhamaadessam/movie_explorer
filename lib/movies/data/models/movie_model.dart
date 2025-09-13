import 'dart:convert';

import 'package:movie_explorer/movies/domain/entities/movie.dart';

class MovieModel extends Movie {
  const MovieModel({
    required super.id,
    required super.title,
    required super.posterImage,
    required super.overview,
    required super.voteAverage,
    required super.releaseDate,
    required super.totalPages,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) => MovieModel(
    id: json["id"] ?? 0,
    title: json["title"] ?? '',
    posterImage: json["poster_path"] ?? '',
    overview: json["overview"] ?? '',
    voteAverage: json["vote_average"].toDouble(),
    releaseDate: json["release_date"],
    totalPages: json["total_pages"] ?? 0,
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "poster_path": posterImage,
    "overview": overview,
    "vote_average": voteAverage,
    "release_date": releaseDate,
    "total_pages": totalPages,
  };

  /// For storing in SharedPreferences as String
  String toRawJson() => json.encode(toJson());

  factory MovieModel.fromRawJson(String str) =>
      MovieModel.fromJson(json.decode(str));
}
