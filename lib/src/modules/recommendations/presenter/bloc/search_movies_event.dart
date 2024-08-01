abstract class SearchMoviesEvent {}

class SearchMovies extends SearchMoviesEvent {
  final String prompt;

  SearchMovies(this.prompt);
}
