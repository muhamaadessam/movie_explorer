import 'package:get_it/get_it.dart';
import 'package:movie_explorer/features/movies/data/datasource/movie_remote_data_source.dart';
import 'package:movie_explorer/features/movies/data/repository/movies_repository.dart';
import 'package:movie_explorer/features/movies/domain/repository/base_movies_repository.dart';
import 'package:movie_explorer/features/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:movie_explorer/features/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_explorer/features/movies/presentation/controller/movie_details/movie_details_cubit.dart';

import '../../features/favorites/presentation/controller/favorites_cubit.dart';
import '../../features/movies/presentation/controller/movies/movies_cubit.dart';
import '../../features/search/data/datasource/movie_remote_data_source.dart';
import '../../features/search/data/repository/search_repository.dart';
import '../../features/search/domain/repository/base_search_repository.dart';
import '../../features/search/domain/usecases/search_movies_usecase.dart';
import '../../features/search/presentation/controller/search_cubit.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    ///Movies

    /// Bloc
    sl.registerFactory(() => MoviesCubit(sl()));
    sl.registerFactory(() => MovieDetailsCubit(sl()));
    sl.registerFactory(() => FavoritesCubit());

    /// Use Cases
    sl.registerLazySingleton(() => GetPopularMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetMovieDetailsUseCase(sl()));

    /// Repository
    sl.registerLazySingleton<BaseMoviesRepository>(
      () => MoviesRepository(sl()),
    );

    /// DATA SOURCE
    sl.registerLazySingleton<BaseMovieRemoteDataSource>(
      () => MovieRemoteDataSource(),
    );

    ///Search
    /// Bloc
    sl.registerFactory(() => SearchCubit(sl()));

    /// Use Cases
    sl.registerLazySingleton(() => SearchMoviesUseCase(sl()));

    /// Repository
    sl.registerLazySingleton<BaseSearchRepository>(
      () => SearchRepository(sl()),
    );

    /// DATA SOURCE
    sl.registerLazySingleton<BaseSearchRemoteDataSource>(
      () => SearchRemoteDataSource(),
    );
  }
}
