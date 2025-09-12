import 'package:get_it/get_it.dart';
import 'package:movie_explorer/movies/data/datasource/movie_remote_data_source.dart';
import 'package:movie_explorer/movies/data/repository/movies_repository.dart';
import 'package:movie_explorer/movies/domain/repository/base_movies_repository.dart';
import 'package:movie_explorer/movies/domain/usecases/get_movie_details_usecase.dart';
import 'package:movie_explorer/movies/domain/usecases/get_popular_movies_usecase.dart';
import 'package:movie_explorer/movies/presentation/controller/movie_details/movie_details_cubit.dart';
import 'package:movie_explorer/movies/presentation/controller/movies/movies_cubit.dart';

import '../../movies/domain/usecases/search_movies_usecase.dart';
import '../../movies/presentation/controller/favorites/favorites_cubit.dart';
import '../../movies/presentation/controller/search/search_cubit.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    print("Initializing ServicesLocator...");

    /// Bloc
    sl.registerFactory(() => MoviesCubit(sl()));
    sl.registerFactory(() => MovieDetailsCubit(sl()));
    sl.registerFactory(() => FavoritesCubit());
    sl.registerFactory(() => SearchCubit(sl()));

    /// Use Cases
    sl.registerLazySingleton(() => GetPopularMoviesUseCase(sl()));
    sl.registerLazySingleton(() => GetMovieDetailsUseCase(sl()));
    sl.registerLazySingleton(() => SearchMoviesUseCase(sl()));

    /// Repository
    sl.registerLazySingleton<BaseMoviesRepository>(
      () => MoviesRepository(sl()),
    );

    /// DATA SOURCE
    sl.registerLazySingleton<BaseMovieRemoteDataSource>(
      () => MovieRemoteDataSource(),
    );
  }
}
