part of 'search_cubit.dart';

class SearchState extends Equatable {
  final RequestState status;
  final List<Movie> results;

  const SearchState({this.status = RequestState.init, this.results = const []});

  SearchState copyWith({RequestState? status, List<Movie>? results}) {
    return SearchState(
      status: status ?? this.status,
      results: results ?? this.results,
    );
  }

  @override
  List<Object?> get props => [status, results];
}
