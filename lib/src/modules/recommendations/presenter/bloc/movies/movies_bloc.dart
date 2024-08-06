import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_recommender_app/src/core/storage/storage.dart';
import 'package:movie_recommender_app/src/modules/recommendations/domain/entities/movie_request_data.dart';
import 'package:movie_recommender_app/src/modules/recommendations/presenter/bloc/movies/movies_event.dart';
import 'package:movie_recommender_app/src/modules/recommendations/presenter/bloc/movies/movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final Storage _storage;
  List<MovieRequestData> _movies = [];
  MoviesBloc(this._storage) : super(MoviesInitialState()) {
    on<Movies>(_fetch);
    on<AddMovie>(_onAddMovie);
    on<ClearMovie>(_onClearMovies);
  }

  Future<void> _fetch(
    Movies event,
    Emitter<MoviesState> emit,
  ) async {
    emit(MoviesLoadingState());
    final moviesFromStorage = _storage.getItem(kMovies);
    if (moviesFromStorage == null || moviesFromStorage.isEmpty) {
      emit(MoviesInitialState());
    } else {
      _movies = (jsonDecode(moviesFromStorage) as List)
          .map((movie) => MovieRequestData.fromMap(movie))
          .toList();
      emit(MoviesSuccessState((List.from(_movies))));
    }
  }

  Future<void> _onAddMovie(
    AddMovie event,
    Emitter<MoviesState> emit,
  ) async {
    emit(MoviesLoadingState());
    final moviesFromStorage = _storage.getItem(kMovies);
    if (moviesFromStorage != null && moviesFromStorage.isNotEmpty) {
      _movies = (jsonDecode(moviesFromStorage) as List)
          .map((movie) => MovieRequestData.fromMap(movie))
          .toList();
    }
    _movies = [..._movies, event.movie];
    await _storage.setItem(
      kMovies,
      jsonEncode([..._movies.map((movie) => movie.toMap())]),
    );
    emit(MoviesSuccessState(_movies));
  }

  Future<void> _onClearMovies(
    ClearMovie event,
    Emitter<MoviesState> emit,
  ) async {
    final result = await _storage.remove(kMovies);
    if (!result) {
      emit(
        MoviesErrorState(errorMessage: StackTrace.current.toString()),
      );
    } else {
      emit(MoviesInitialState());
    }
  }
}
