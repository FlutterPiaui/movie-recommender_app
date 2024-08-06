import 'package:dartz/dartz.dart';
import 'package:movie_recommender_app/src/core/client/api_client.dart';

import 'package:movie_recommender_app/src/core/errors/errors.dart';
import '../../domain/entities/movie.dart';
import '../../domain/repositories/recommendation_repository.dart';

class RecommendationRepositoryImpl implements RecommendationRepository {
  final ApiClient _apiClient;

  RecommendationRepositoryImpl(this._apiClient);

  @override
  Future<Either<Failure, List<Movie>>> getRecommendations(String prompt) async {
    try {
      final response = await _apiClient.post(
        path: '/gemini',
        data: {"prompt": prompt, "language": "português"},
      );

      var movies =
          (response.data as List).map((movie) => Movie.fromJson(movie)).toList();

      return right(movies);
    } catch (e) {
      return left(GetFailureMovies(errorMessage: e.toString()));
    }
  }
}
