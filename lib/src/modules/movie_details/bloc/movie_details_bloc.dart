import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_recommender_app/src/modules/movie_details/bloc/movie_details_event.dart';
import 'package:movie_recommender_app/src/modules/movie_details/bloc/movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  MovieDetailsBloc() : super(MovieDetailsInitialState()) {
    on<GetMovieDetails>(_fetch);
  }

  Future<void> _fetch(
    GetMovieDetails event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(MovieDetailsLoadingState());
  }
}
