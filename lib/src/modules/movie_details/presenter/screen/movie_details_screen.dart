import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie_recommender_app/src/core/enums/sized_enum.dart';
import 'package:movie_recommender_app/src/core/extensions/ui/media_query_extensions.dart';
import 'package:movie_recommender_app/src/core/extensions/ui/sizes_extensions.dart';
import 'package:movie_recommender_app/src/core/shared/widgets/others/info_details_movie.dart';
import 'package:movie_recommender_app/src/core/shared/widgets/others/star_rating_widget.dart';
import 'package:movie_recommender_app/src/di/di_setup.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_recommender_app/src/presentation/home/screen/widgets/recommendation_movie_widget.dart';

import '../bloc/movie_details_bloc.dart';
import '../bloc/movie_details_event.dart';
import '../bloc/movie_details_state.dart';
import 'trailler_page_player.dart';

class MovieDetailsScreen extends StatefulWidget {
  final String movieName;
  static const routeName = '/movie-details';
  const MovieDetailsScreen({super.key, required this.movieName});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  final movieDetailsBloc = getIt<MovieDetailsBloc>();
  @override
  void initState() {
    movieDetailsBloc.add(GetMovieDetails(movieName: widget.movieName));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final str = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final loading = LoadingAnimationWidget.fourRotatingDots(
      color: theme.colorScheme.onTertiary,
      size: 40,
    );
    final decoration = BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black,
          Colors.black.withOpacity(0.95),
          Colors.black.withOpacity(0.9),
        ],
      ),
    );
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      bloc: movieDetailsBloc,
      builder: (context, state) {
        if (state is MovieDetailsLoadingState) {
          return Material(
            child: Container(
              decoration: decoration,
              child: Center(child: loading),
            ),
          );
        }
        if (state is MovieDetailsErrorState) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            ),
            extendBody: true,
            extendBodyBehindAppBar: true,
            body: Container(
              decoration: decoration,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error, color: theme.colorScheme.onTertiary),
                    const SizedBox(height: 16),
                    Text(
                      str.somethingWentWrong,
                      style: theme.textTheme.bodyMedium!.copyWith(
                        color: theme.colorScheme.onTertiary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        if (state is MovieDetailsSuccessState) {
          var genres = state.movie.genres;
          if (state.movie.releaseDate?.year != null) {
            genres.insert(0, state.movie.releaseDate!.year.toString());
          }
          return Scaffold(
            extendBodyBehindAppBar: true,
            backgroundColor: theme.colorScheme.onSecondary,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: theme.colorScheme.onTertiary,
                ),
              ),
            ),
            body: Column(
              children: [
                Stack(
                  children: [
                    Image.network(
                      state.movie.posterUrl,
                      height: context.getHeight * 0.46,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.fill,
                    ),
                    Positioned(
                      bottom: 0,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8, left: 8),
                        child: StarRatingWidget(rating: (7.5 / 2).round()),
                      ),
                    )
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      decoration: decoration,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.fromLTRB(
                          SizesEnum.md.getSize,
                          0,
                          SizesEnum.md.getSize,
                          0,
                        ),
                        child: Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 10),
                              Text(
                                state.movie.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  ElevatedButton.icon(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.blue,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                    ),
                                    icon: const Icon(
                                      Icons.play_circle,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                    label: Text(
                                      str.whereWatch,
                                      style:
                                          theme.textTheme.titleSmall!.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  if (state.movie.trailerUrl != null)
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        context.push(
                                          '${PlayerYoutube.routeName}?urlMovie=${state.movie.trailerUrl}',
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 25,
                                        ),
                                      ),
                                      icon: const Icon(
                                        Icons.movie_filter,
                                        size: 25,
                                        color: Colors.white,
                                      ),
                                      label: Text(
                                        'Trailler',
                                        style: theme.textTheme.titleSmall!
                                            .copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height: 35,
                                child: ListView(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  children: state.movie.genres
                                      .map(
                                        (genre) => Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8),
                                          child: InfoDetailsMovie(
                                            textInfo: genre,
                                          ),
                                        ),
                                      )
                                      .toList(),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Row(
                                children: [
                                  Text(
                                    '+16',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    '•',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(width: 8.0),
                                  Text(
                                    '2h 15m',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Text(
                                state.movie.overview,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.all(12),
                                height: 200,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      str.recommendedMovies,
                                      style:
                                          theme.textTheme.titleMedium!.copyWith(
                                        color: theme.colorScheme.onTertiary,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Expanded(
                                      child: ListView.builder(
                                        padding: const EdgeInsets.all(0),
                                        scrollDirection: Axis.horizontal,
                                        itemCount: 4,
                                        itemBuilder: (context, index) {
                                          final movie = state
                                              .movie.recommendations[index];
                                          return RecommendationMovieWidget(
                                            title: movie.title,
                                            image: movie.posterUrl,
                                            size: const Size(150, 120),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
