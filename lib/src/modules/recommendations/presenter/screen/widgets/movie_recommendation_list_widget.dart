import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/entities/movie_request_data.dart';
import '../../bloc/movies/movies_bloc.dart';
import '../../bloc/movies/movies_event.dart';
import '../../bloc/search_movies/search_movies_bloc.dart';
import '../../bloc/search_movies/search_movies_event.dart';

class MovieRecommendationListWidget extends StatelessWidget {
  const MovieRecommendationListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final recommendations = MovieRecommendationItem.recommendations(context);
    return Container(
      height: 94,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: recommendations
            .map(
              (recommendation) => GestureDetector(
                onTap: () {
                  context.read<SearchMoviesBloc>().add(
                        SearchMovies(recommendation.name),
                      );
                  context.read<MoviesBloc>().add(
                        AddMovie(
                          MovieRequestData(
                            movies: [],
                            prompt: recommendation.name,
                            error: null,
                            isFailed: true,
                          ),
                        ),
                      );
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 16),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.grey.shade800, width: 2),
                  ),
                  height: 80,
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(recommendation.icon, height: 26),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              recommendation.name,
                              style: theme.textTheme.labelMedium!.copyWith(
                                color: theme.colorScheme.onTertiary,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

class MovieRecommendationItem {
  MovieRecommendationItem({required this.name, required this.icon});
  final String name;
  final String icon;

  final year = DateTime.now().year;

  static List<MovieRecommendationItem> recommendations(BuildContext context) {
    final str = AppLocalizations.of(context)!;

    return [
      MovieRecommendationItem(
        name: '${str.bestMoviesOf} 2023',
        icon: 'assets/icons/favorites.png',
      ),
      MovieRecommendationItem(
        name: str.moviesBasedTrueStories,
        icon: 'assets/icons/checklist.png',
      ),
      MovieRecommendationItem(
        name: str.oscarWinningMovies,
        icon: 'assets/icons/oscar.png',
      ),
      MovieRecommendationItem(
        name: str.bestHorrorMovies,
        icon: 'assets/icons/ghost.png',
      ),
      MovieRecommendationItem(
        name: str.bestComedyMovies,
        icon: 'assets/icons/lol.png',
      ),
    ];
  }
}
