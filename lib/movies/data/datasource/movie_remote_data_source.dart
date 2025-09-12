import 'package:movie_explorer/core/error/exceptions.dart';
import 'package:movie_explorer/core/network/Remote/api_constance.dart';
import 'package:movie_explorer/core/network/Remote/dio_helper.dart';
import 'package:movie_explorer/core/network/error_message_model.dart';
import 'package:movie_explorer/movies/data/models/movie_model.dart';
import 'package:movie_explorer/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:movie_explorer/movies/domain/usecases/search_movies_usecase.dart';

abstract class BaseMovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies(parameters);

  Future<MovieModel> getMovieDetails(MovieDetailsParameters parameters);

  Future<List<MovieModel>> searchMovies(SearchMoviesParameters parameters);
}

class MovieRemoteDataSource extends BaseMovieRemoteDataSource {
  @override
  Future<List<MovieModel>> getPopularMovies(parameters) async {
    final response = await DioHelper.getData(
      endPoint: ApiConstance.popularMoviesPath,
      query: {"page": parameters.page},
    );

    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data["results"] as List).map((e) => MovieModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<MovieModel> getMovieDetails(MovieDetailsParameters parameters) async {
    final response = await DioHelper.getData(
      endPoint: ApiConstance.movieDetailsPath(parameters.movieId),
    );

    if (response.statusCode == 200) {
      return MovieModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(
    SearchMoviesParameters parameters,
  ) async {
    final response = await DioHelper.getData(
      endPoint: ApiConstance.searchMoviesPath,
      query: {"query": parameters.query},
    );

    if (response.statusCode == 200) {
      return List<MovieModel>.from(
        (response.data["results"] as List).map((e) => MovieModel.fromJson(e)),
      );
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
