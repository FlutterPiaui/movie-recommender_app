import 'package:dartz/dartz.dart';
import 'package:movie_recommender_app/src/modules/recommendations/domain/entities/movie.dart';

import '../../../../core/errors/errors.dart';

abstract class RecommendationRepository {
  Future<Either<Failure, List<Movie>>> getRecommendations(String prompt);
}
