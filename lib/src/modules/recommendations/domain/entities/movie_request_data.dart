import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:movie_recommender_app/src/modules/recommendations/domain/entities/movie.dart';

class MovieRequestData {
  MovieRequestData({
    required this.movies,
    required this.prompt,
    this.error,
    this.isFailed = false,
  });

  final List<Movie> movies;
  final String prompt;
  final String? error;
  final bool isFailed;

  MovieRequestData copyWith({
    List<Movie>? movies,
    String? prompt,
    String? error,
    bool? isFailed,
  }) {
    return MovieRequestData(
      movies: movies ?? this.movies,
      prompt: prompt ?? this.prompt,
      error: error ?? this.error,
      isFailed: isFailed ?? this.isFailed,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'movies': movies.map((x) => x.toMap()).toList(),
      'input': prompt,
      'error': error,
      'isFailed': isFailed,
    };
  }

  factory MovieRequestData.fromMap(Map<String, dynamic> map) {
    return MovieRequestData(
      movies: (map['movies'] as List)
          .map<Movie>(
            (x) => Movie.fromMap(x),
          )
          .toList(),
      prompt: map['input'],
      error: map['error'] != null ? map['error'] as String : null,
      isFailed: map['isFailed'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MovieRequestData.fromJson(String source) =>
      MovieRequestData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'MovieRequestData(movies: $movies, input: $prompt, error: $error, isFailed: $isFailed)';

  @override
  bool operator ==(covariant MovieRequestData other) {
    if (identical(this, other)) return true;

    return listEquals(other.movies, movies) &&
        other.prompt == prompt &&
        other.error == error &&
        other.isFailed == isFailed;
  }

  @override
  int get hashCode =>
      movies.hashCode ^ prompt.hashCode ^ error.hashCode ^ isFailed.hashCode;
}
