import 'package:dartz/dartz.dart';
import 'package:movie_recommender_app/src/core/client/api_client.dart';

import 'package:movie_recommender_app/src/core/errors/errors.dart';
import 'package:movie_recommender_app/src/modules/movie_details/domain/repositories/movie_details_repository.dart';

import '../../domain/entities/movie_details.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final ApiClient _apiClient;

  MovieDetailsRepositoryImpl(this._apiClient);

  @override
  Future<Either<Failure, MovieDetails>> getMovieDetails(
      String movieName) async {
    try {
      final response = await _apiClient.get(path: '/movie/$movieName');
      var movie = MovieDetails.fromJson(response.data);
      return right(movie);
    } catch (e) {
      return left(GetFailureMovieDetails(errorMessage: e.toString()));
    }
  }
}
