part of 'favorites_cubit.dart';

enum FavoritesStatus { initial, loading, success, failure }

class FavoritesState extends Equatable {
  final FavoritesStatus status;
  final List<MovieModel> favorites;

  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.favorites = const [],
  });

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<MovieModel>? favorites,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
    );
  }

  @override
  List<Object?> get props => [status, favorites];
}
