abstract class MovieDetailsEvent {}

class GetMovieDetails extends MovieDetailsEvent {
  final String movieName;
  GetMovieDetails({
    required this.movieName,
  });
}
