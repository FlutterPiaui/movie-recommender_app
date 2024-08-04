import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_recommender_app/src/modules/recommendations/domain/repositories/recommendation_repository.dart';
import 'package:movie_recommender_app/src/modules/recommendations/presenter/bloc/search_movies_event.dart';
import 'package:movie_recommender_app/src/modules/recommendations/presenter/bloc/search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  final RecommendationRepository repository;
  SearchMoviesBloc(this.repository) : super(SearchMoviesInitialState()) {
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
        emit(SearchMoviesErrorState(errorMessage: failure.errorMessage));
      },
      (movies) {
        emit(SearchMoviesSuccessState(movies));
      },
    );
  }
}
