part of 'search_cubit.dart';

class SearchState extends Equatable {
  final RequestState status;
  final List<Movie> results;
  final String searchMessage;
  final String query;

  const SearchState({
    this.status = RequestState.init,
    this.results = const [],
    this.searchMessage = "",
    this.query = "",
  });

  SearchState copyWith({
    RequestState? status,
    List<Movie>? results,
    String? searchMessage,
    String? query,
  }) {
    return SearchState(
      status: status ?? this.status,
      results: results ?? this.results,
      searchMessage: searchMessage ?? this.searchMessage,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [status, results, searchMessage];
}
