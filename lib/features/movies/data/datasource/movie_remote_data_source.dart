import 'package:movie_explorer/core/error/exceptions.dart';
import 'package:movie_explorer/core/network/Remote/api_constance.dart';
import 'package:movie_explorer/core/network/Remote/dio_helper.dart';
import 'package:movie_explorer/core/network/error_message_model.dart';
import 'package:movie_explorer/core/network/movies_list_with_pagination.dart';
import 'package:movie_explorer/features/movies/data/models/movie_model.dart';
import 'package:movie_explorer/features/movies/domain/usecases/get_movie_details_usecase.dart';

abstract class BaseMovieRemoteDataSource {
  Future<MoviesListWithPaginationModel> getPopularMovies(parameters);

  Future<MovieModel> getMovieDetails(MovieDetailsParameters parameters);
}

class MovieRemoteDataSource extends BaseMovieRemoteDataSource {
  @override
  Future<MoviesListWithPaginationModel> getPopularMovies(parameters) async {
    final response = await DioHelper.getData(
      endPoint: ApiConstance.popularMoviesPath,
      query: {"page": parameters.page},
    );

    if (response.statusCode == 200) {
      return MoviesListWithPaginationModel.fromJson(response.data);
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
}
