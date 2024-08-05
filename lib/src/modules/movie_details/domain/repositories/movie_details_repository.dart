import 'package:dartz/dartz.dart';

import '../../../../core/errors/errors.dart';
import '../entities/movie_details.dart';

abstract class MovieDetailsRepository {
  Future<Either<Failure, MovieDetails>> getMovieDetails(String movieName);
}
