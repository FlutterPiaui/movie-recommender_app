import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movie_recommender_app/src/core/errors/errors.dart';
import 'package:movie_recommender_app/src/modules/movie_details/domain/entities/movie_details.dart';
import 'package:movie_recommender_app/src/modules/movie_details/domain/repositories/movie_details_repository.dart';
import 'package:movie_recommender_app/src/modules/movie_details/presenter/bloc/movie_details_bloc.dart';
import 'package:movie_recommender_app/src/modules/movie_details/presenter/bloc/movie_details_event.dart';
import 'package:movie_recommender_app/src/modules/movie_details/presenter/bloc/movie_details_state.dart';

class MovieDetailsRepositoryMock extends Mock
    implements MovieDetailsRepository {}

void main() {
  late MovieDetailsBloc bloc;
  late MovieDetailsRepositoryMock repositoryMock;

  setUp(() {
    repositoryMock = MovieDetailsRepositoryMock();
    bloc = MovieDetailsBloc(repositoryMock);
  });
  blocTest<MovieDetailsBloc, MovieDetailsState>(
    'shoudl emits [MovieDetailsSuccessState] when GetMovieDetails is added.',
    build: () => bloc,
    setUp: () {
      when(
        () => repositoryMock.getMovieDetails(any()),
      ).thenAnswer((_) async => Right(MovieDetails.fromJson(mock)));
    },
    act: (bloc) {
      bloc.add(GetMovieDetails(movieName: 'Teste'));
    },
    expect: () => [
      isA<MovieDetailsLoadingState>(),
      isA<MovieDetailsSuccessState>(),
    ],
    verify: (_) {
      verify(() => repositoryMock.getMovieDetails(any())).called(1);
      verifyNoMoreInteractions(repositoryMock);
    },
  );
  blocTest<MovieDetailsBloc, MovieDetailsState>(
    'shoudl emits [MovieDetailsErrorState] when GetMovieDetails is added.',
    build: () => bloc,
    setUp: () {
      when(() => repositoryMock.getMovieDetails(any())).thenAnswer(
          (_) async => Left(GetFailureMovieDetails(errorMessage: 'oops')));
    },
    act: (bloc) {
      bloc.add(GetMovieDetails(movieName: 'Teste'));
    },
    expect: () => [
      isA<MovieDetailsLoadingState>(),
      isA<MovieDetailsErrorState>(),
    ],
    verify: (_) {
      verify(() => repositoryMock.getMovieDetails(any())).called(1);
      verifyNoMoreInteractions(repositoryMock);
    },
  );
}

var mock = {
  "adult": false,
  "backdrop_path": "/9Cip74Gl1xOkRP0e4OAiPZp8C4k.jpg",
  "belongs_to_collection": null,
  "budget": 40000000,
  "genres": [
    {"id": 28, "name": "Action"},
    {"id": 12, "name": "Adventure"},
    {"id": 18, "name": "Drama"},
    {"id": 10751, "name": "Family"}
  ],
  "homepage": "https://www.sonypictures.com/movies/thekaratekid",
  "id": 38575,
  "imdb_id": "tt1155076",
  "origin_country": ["US"],
  "original_language": "en",
  "original_title": "The Karate Kid",
  "overview":
      "Twelve-year-old Dre Parker could have been the most popular kid in Detroit, but his mother's latest career move has landed him in China. Dre immediately falls for his classmate Mei Ying but the cultural differences make such a friendship impossible. Even worse, Dre's feelings make him an enemy of the class bully, Cheng. With no friends in a strange land, Dre has nowhere to turn but maintenance man Mr. Han, who is a kung fu master. As Han teaches Dre that kung fu is not about punches and parries, but maturity and calm, Dre realizes that facing down the bullies will be the fight of his life.",
  "popularity": 139.925,
  "poster_path": "/bHjLC5GuBfeyW6ZE07x6TalKj19.jpg",
  "production_companies": [
    {
      "id": 2596,
      "logo_path": null,
      "name": "Jerry Weintraub Productions",
      "origin_country": "US"
    },
    {
      "id": 5,
      "logo_path": "/71BqEFAF4V3qjjMPCpLuyJFB9A.png",
      "name": "Columbia Pictures",
      "origin_country": "US"
    },
    {
      "id": 5635,
      "logo_path": null,
      "name": "China Film Group",
      "origin_country": ""
    },
    {
      "id": 907,
      "logo_path": "/ca5SWI5uvU985f8Kbb4xc8AmVWH.png",
      "name": "Overbrook Entertainment",
      "origin_country": "US"
    },
    {
      "id": 44997,
      "logo_path": "/gmPqRmgvgsbymBsfzumUw2ARifD.png",
      "name": "Zwart Arbeid",
      "origin_country": "NO"
    }
  ],
  "production_countries": [
    {"iso_3166_1": "CN", "name": "China"},
    {"iso_3166_1": "US", "name": "United States of America"}
  ],
  "release_date": "2010-06-10",
  "revenue": 359126022,
  "runtime": 140,
  "spoken_languages": [
    {"english_name": "Mandarin", "iso_639_1": "zh", "name": "普通话"},
    {"english_name": "English", "iso_639_1": "en", "name": "English"}
  ],
  "status": "Released",
  "tagline": "A Challenge He Never Imagined. A Teacher He Never Expected.",
  "title": "The Karate Kid",
  "video": false,
  "vote_average": 6.5,
  "vote_count": 5851,
  "poster_url":
      "https://image.tmdb.org/t/p/w600_and_h900_bestv2//bHjLC5GuBfeyW6ZE07x6TalKj19.jpg"
};
