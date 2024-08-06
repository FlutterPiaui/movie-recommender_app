import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_recommender_app/src/modules/movie_details/presenter/screen/movie_details_screen.dart';
import 'package:movie_recommender_app/src/modules/recommendations/domain/entities/movie.dart';
import 'package:shimmer/shimmer.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget(this.movies, {super.key});

  final List<Movie> movies;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 174,
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.push(
                        MovieDetailsScreen.routeName,
                        extra: movies[index],
                      );
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
                  const SizedBox(height: 6),
                  Container(
                    width: 120,
                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                    child: Text(
                      movies[index].title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: theme.colorScheme.onTertiary,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
              itemCount: movies.length,
            ),
          ),
        ],
      ),
    );
  }
}
