import 'package:movie_recommender_app/src/modules/recommendations/domain/entities/movie_request_data.dart';

abstract class MoviesEvent {}

class Movies extends MoviesEvent {
  final List<MovieRequestData> movies;
  Movies(this.movies);
}

class AddMovie extends MoviesEvent {
  final MovieRequestData movie;
  AddMovie(this.movie);
}

class ClearMovie extends MoviesEvent {}
