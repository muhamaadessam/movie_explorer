import 'package:movie_explorer/core/error/exceptions.dart';
import 'package:movie_explorer/core/network/Remote/api_constance.dart';
import 'package:movie_explorer/core/network/Remote/dio_helper.dart';
import 'package:movie_explorer/core/network/error_message_model.dart';
import 'package:movie_explorer/core/network/movies_list_with_pagination.dart';

import '../../domain/usecases/search_movies_usecase.dart';

abstract class BaseSearchRemoteDataSource {
  Future<MoviesListWithPaginationModel> searchMovies(
    SearchMoviesParameters parameters,
  );
}

class SearchRemoteDataSource extends BaseSearchRemoteDataSource {
  @override
  Future<MoviesListWithPaginationModel> searchMovies(
    SearchMoviesParameters parameters,
  ) async {
    final response = await DioHelper.getData(
      endPoint: ApiConstance.searchMoviesPath,
      query: {"query": parameters.query, "page": parameters.page},
    );

    if (response.statusCode == 200) {
      return MoviesListWithPaginationModel.fromJson(response.data);
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(response.data),
      );
    }
  }
}
