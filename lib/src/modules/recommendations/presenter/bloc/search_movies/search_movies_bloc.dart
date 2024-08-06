import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_recommender_app/src/modules/recommendations/domain/entities/movie_request_data.dart';
import 'package:movie_recommender_app/src/modules/recommendations/domain/repositories/recommendation_repository.dart';
import 'package:movie_recommender_app/src/modules/recommendations/presenter/bloc/movies/movies_event.dart';
import 'package:movie_recommender_app/src/modules/recommendations/presenter/bloc/search_movies/search_movies_event.dart';
import 'package:movie_recommender_app/src/modules/recommendations/presenter/bloc/search_movies/search_movies_state.dart';

import '../movies/movies_bloc.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final RecommendationRepository repository;
  final MoviesBloc _moviesBloc;

  SearchMoviesBloc(this.repository, this._moviesBloc)
      : super(SearchMoviesInitialState()) {
    on<SearchMovies>(_fetch);
  }

  Future<void> _fetch(
    SearchMovies event,
    Emitter<SearchMoviesState> emit,
  ) async {
    emit(SearchMoviesLoadingState());
    final result = await repository.getRecommendations(event.prompt);
    result.fold(
      (failure) {
        final error = failure.errorMessage;
        _moviesBloc.add(
          AddMovie(
            MovieRequestData(movies: [], prompt: event.prompt, error: error),
          ),
        );
        emit(SearchMoviesErrorState(errorMessage: error));
      },
      (movies) {
        _moviesBloc.add(
          AddMovie(
            MovieRequestData(movies: movies, prompt: event.prompt),
          ),
        );
        emit(SearchMoviesSuccessState(movies));
      },
    );
  }
}
