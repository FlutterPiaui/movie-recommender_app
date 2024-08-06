import 'package:movie_recommender_app/src/modules/recommendations/domain/entities/movie.dart';

abstract class SearchMoviesState {}

class SearchMoviesSuccessState extends SearchMoviesState {
  final List<Movie> movies;

  SearchMoviesSuccessState(this.movies);
}

class SearchMoviesErrorState extends SearchMoviesState {
  final String errorMessage;
  SearchMoviesErrorState({required this.errorMessage});
}

class SearchMoviesLoadingState extends SearchMoviesState {}

class SearchMoviesInitialState extends SearchMoviesState {}
