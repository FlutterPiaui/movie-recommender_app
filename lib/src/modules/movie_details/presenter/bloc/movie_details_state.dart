import 'package:movie_recommender_app/src/modules/movie_details/domain/entities/movie_details.dart';

abstract class MovieDetailsState {}

class MovieDetailsSuccessState extends MovieDetailsState {
  final MovieDetails movie;

  MovieDetailsSuccessState({required this.movie});
}

class MovieDetailsErrorState extends MovieDetailsState {
  final String errorMessage;

  MovieDetailsErrorState(this.errorMessage);
}

class MovieDetailsLoadingState extends MovieDetailsState {}

class MovieDetailsInitialState extends MovieDetailsState {}
