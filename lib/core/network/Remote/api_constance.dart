class ApiConstance {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String apiKey = "ce6a794714557b60b918edc26919aa65";

  static const String popularMoviesPath =
      "$baseUrl/movie/popular?api_key=$apiKey";

  static String movieDetailsPath(int movieId) =>
      "$baseUrl/movie/$movieId?api_key=$apiKey";

  static String searchMoviesPath = "$baseUrl/search/movie?api_key=$apiKey";

  static const String baseImageUrl = 'https://image.tmdb.org/t/p/w500';

  static String imageUrl(String path) => '$baseImageUrl$path';
}
