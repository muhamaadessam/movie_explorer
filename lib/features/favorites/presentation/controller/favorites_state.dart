part of 'favorites_cubit.dart';

enum FavoritesStatus { initial, loading, success, failure }

class FavoritesState extends Equatable {
  final FavoritesStatus status;
  final List<MovieModel> favorites;
  final String favoritesMessage;

  const FavoritesState({
    this.status = FavoritesStatus.initial,
    this.favorites = const [],
    this.favoritesMessage = '',
  });

  FavoritesState copyWith({
    FavoritesStatus? status,
    List<MovieModel>? favorites,
    String? favoritesMessage,
  }) {
    return FavoritesState(
      status: status ?? this.status,
      favorites: favorites ?? this.favorites,
      favoritesMessage: favoritesMessage ?? this.favoritesMessage,
    );
  }

  @override
  List<Object?> get props => [status, favorites, favoritesMessage];
}
