import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_recommender_app/src/core/enums/sized_enum.dart';
import 'package:movie_recommender_app/src/core/extensions/ui/media_query_extensions.dart';
import 'package:movie_recommender_app/src/core/extensions/ui/sizes_extensions.dart';
import 'package:movie_recommender_app/src/core/shared/widgets/others/info_details_movie.dart';
import 'package:movie_recommender_app/src/core/shared/widgets/others/star_rating_widget.dart';
import 'package:movie_recommender_app/src/di/di_setup.dart';

import '../bloc/movie_details_bloc.dart';
import '../bloc/movie_details_event.dart';
import '../bloc/movie_details_state.dart';

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
                          size: 38,
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
                    child: SingleChildScrollView(
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
                          StarRatingWidget(rating: (7.5 / 2).round()),
                          const SizedBox(height: 10),
                          Text(
                            state.movie.title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10),
                          const Row(
                            children: [
                              InfoDetailsMovie(
                                textInfo: '2022',
                              ),
                              SizedBox(width: 12),
                              InfoDetailsMovie(
                                textInfo: 'Action',
                              ),
                              SizedBox(width: 12),
                              InfoDetailsMovie(
                                textInfo: 'USA',
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 25),
                                ),
                                child: const Text(
                                  'Whatch Now',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 25),
                                child: CircleAvatar(
                                  backgroundColor: Colors.grey.withOpacity(0.5),
                                  radius: 22,
                                  child: IconButton(
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.download_outlined,
                                      size: 25,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              CircleAvatar(
                                backgroundColor: Colors.grey.withOpacity(0.5),
                                radius: 22,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.bookmark_add_outlined,
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
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
                          const SizedBox(height: 20),
                          Text(
                            state.movie.overview,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
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
