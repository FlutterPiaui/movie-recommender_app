import 'package:movie_recommender_app/src/modules/recommendations/domain/entities/movie_request_data.dart';

abstract class MoviesState {}

class MoviesSuccessState extends MoviesState {
  final List<MovieRequestData> movies;

  MoviesSuccessState(this.movies);
}

class MoviesErrorState extends MoviesState {
  final String errorMessage;
  MoviesErrorState({required this.errorMessage});
}

class MoviesLoadingState extends MoviesState {}

class MoviesInitialState extends MoviesState {
}
