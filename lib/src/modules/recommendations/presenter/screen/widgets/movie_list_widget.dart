import 'package:flutter/material.dart';
import 'package:movie_recommender_app/src/modules/recommendations/domain/entities/movie.dart';
import 'recommendation_movie_widget.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget(this.movies, {super.key});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 174,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => RecommendationMovieWidget(
                title: movies[index].title,
                image: movies[index].image,
              ),
              itemCount: movies.length,
            ),
          ),
        ],
      ),
    );
  }
}
