import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_explorer/features/movies/data/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(const FavoritesState());

  static const _key = "favorites";

  Future<void> loadFavorites() async {
    emit(state.copyWith(status: FavoritesStatus.loading));
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    final movies = list.map((e) => MovieModel.fromRawJson(e)).toList();

    emit(state.copyWith(status: FavoritesStatus.success, favorites: movies));
  }

  Future<void> toggleFavorite(MovieModel movie) async {
    final current = List<MovieModel>.from(state.favorites);
    final exists = current.any((m) => m.id == movie.id);

    if (exists) {
      current.removeWhere((m) => m.id == movie.id);
    } else {
      current.add(movie);
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, current.map((m) => m.toRawJson()).toList());

    emit(state.copyWith(favorites: current));
  }

  bool isFavorite(int movieId) {
    return state.favorites.any((m) => m.id == movieId);
  }
}
