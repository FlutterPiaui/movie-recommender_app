import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_recommender_app/src/modules/recommendations/domain/entities/movie.dart';
import 'package:shimmer/shimmer.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget(this.movies, {super.key});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 160,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  //redirect to movie details
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 8.0),
                  width: 120,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.onTertiary,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: movies[index].image,
                    placeholder: (context, url) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade300,
                      highlightColor: Colors.grey.shade100,
                      child: Container(
                        decoration: BoxDecoration(
                          color: theme.scaffoldBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ),
              ),
              itemCount: movies.length,
            ),
          ),
        ],
      ),
    );
  }
}
