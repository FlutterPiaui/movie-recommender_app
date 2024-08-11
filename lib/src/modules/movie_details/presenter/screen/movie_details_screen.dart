import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_recommender_app/src/core/enums/sized_enum.dart';
import 'package:movie_recommender_app/src/core/extensions/duration_formatter_extension.dart';
import 'package:movie_recommender_app/src/core/extensions/ui/media_query_extensions.dart';
import 'package:movie_recommender_app/src/core/extensions/ui/sizes_extensions.dart';
import 'package:movie_recommender_app/src/core/shared/widgets/others/info_details_movie.dart';
import 'package:movie_recommender_app/src/core/shared/widgets/others/star_rating_widget.dart';
import 'package:movie_recommender_app/src/di/di_setup.dart';
import 'package:movie_recommender_app/src/modules/movie_details/domain/entities/movie_details.dart';
import 'package:movie_recommender_app/src/utils/dialog_utils.dart';

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
    return BlocBuilder<MovieDetailsBloc, MovieDetailsState>(
      bloc: movieDetailsBloc,
      builder: (context, state) {
        if (state is MovieDetailsLoadingState) {
          return const Material(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is MovieDetailsSuccessState) {
          var genres = state.movie.genres;
          if (state.movie.releaseDate?.year != null) {
            genres.insert(0, state.movie.releaseDate!.year.toString());
          }

          return Scaffold(
            body: Stack(
              children: [
                CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      flexibleSpace: Image.network(
                        state.movie.posterUrl,
                        height: context.getHeight,
                        fit: BoxFit.cover,
                      ),
                      collapsedHeight: context.getHeight,
                      stretch: true,
                      leading: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: context.getHeight / 2.5,
                  width: context.getWidth,
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.6),
                          Colors.black.withOpacity(0.9),
                          Colors.black.withOpacity(0.95),
                          Colors.black,
                        ],
                      ),
                    ),
                    height: context.getHeight / 1.5,
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        SizesEnum.md.getSize,
                        0,
                        SizesEnum.md.getSize,
                        0,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          StarRatingWidget(
                              rating: (state.movie.voteAverage / 2).round()),
                          const SizedBox(height: 10),
                          Text(
                            state.movie.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
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
                                      padding: const EdgeInsets.only(right: 8),
                                      child: InfoDetailsMovie(
                                        textInfo: genre,
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  DialogUtils.showProviderInfoDialog(
                                    context: context,
                                    providersList: state.movie.providersList,
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 25,
                                  ),
                                ),
                                icon: const Icon(
                                  Icons.play_circle,
                                  size: 25,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Whatch Where?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
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
                                label: const Text(
                                  'Trailler',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              const Text(
                                '•',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                state.movie.runtime.toHoursMinutesFromMinutes(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 200,
                            child: SingleChildScrollView(
                              child: Text(
                                state.movie.overview,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          )
                        ],
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
