import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_recommender_app/src/modules/movie_details/presenter/bloc/movie_details_event.dart';
import 'package:movie_recommender_app/src/modules/movie_details/presenter/bloc/movie_details_state.dart';
import 'package:movie_recommender_app/src/modules/movie_details/domain/repositories/movie_details_repository.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final MovieDetailsRepository repository;
  MovieDetailsBloc(this.repository) : super(MovieDetailsInitialState()) {
    on<GetMovieDetails>(_fetch);
  }

  Future<void> _fetch(
    GetMovieDetails event,
    Emitter<MovieDetailsState> emit,
  ) async {
    emit(MovieDetailsLoadingState());
    final result = await repository.getMovieDetails(event.movieName);
    result.fold(
      (failure) {
        emit(MovieDetailsErrorState(failure.errorMessage));
      },
      (movie) {
        emit(MovieDetailsSuccessState(movie: movie));
      },
    );
  }
}
