import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_recommender_app/src/presentation/recommendations/bloc/search_movies_event.dart';
import 'package:movie_recommender_app/src/presentation/recommendations/bloc/search_movies_state.dart';

class SearchMoviesBloc extends Bloc<SearchMoviesEvent, SearchMoviesState> {
  SearchMoviesBloc() : super(SearchMoviesInitialState()) {
    on<SearchMovies>(_fetch);
  }

  Future<void> _fetch(
    SearchMovies event,
    Emitter<SearchMoviesState> emit,
  ) async {
    emit(SearchMoviesLoadingState());
  }
}
