import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
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

      var movies = (response.data as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();

      return right(movies);
    } on DioException catch (e) {
      return left(GetFailureMovies(errorMessage: e.message.toString()));
    } on HttpServiceError catch (e) {
      if (e.message.contains('[bad response]')) {
        return left(
          GetFailureMovies(
            errorMessage:
                'Oops! Looks like we couldn\'t find a movie recommendation for you this time. Why not try another search? We\'re here to help you find your next great movie adventure!',
          ),
        );
      } else {
        return left(GetFailureMovies(errorMessage: e.message.toString()));
      }
    }
  }
}
