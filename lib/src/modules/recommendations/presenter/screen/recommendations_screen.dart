import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie_recommender_app/src/modules/recommendations/domain/entities/movie_request_data.dart';
import 'package:movie_recommender_app/src/modules/recommendations/presenter/bloc/movies/movies_event.dart';
import 'package:movie_recommender_app/src/modules/recommendations/presenter/bloc/search_movies/search_movies_state.dart';
import 'package:movie_recommender_app/src/presentation/home/screen/widgets/movie_list_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_recommender_app/src/presentation/home/screen/widgets/movie_recommendation_list_widget.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/theme_provider.dart';
import '../bloc/movies/movies_bloc.dart';
import '../bloc/movies/movies_state.dart';
import '../bloc/search_movies/search_movies_bloc.dart';
import '../bloc/search_movies/search_movies_event.dart';

class RecommendationsScreen extends StatefulWidget {
  static const routeName = '/recommendations';
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  final TextEditingController _controller = TextEditingController();
  int _counter = 0;

  @override
  void initState() {
    context.read<MoviesBloc>().add(Movies([]));
    _controller.addListener(_updateCharCount);

    super.initState();
  }

  void _updateCharCount() {
    setState(() {
      _counter = _controller.text.length;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_updateCharCount);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final theme = Theme.of(context);
    final str = AppLocalizations.of(context)!;

    final movieMessage = Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16),
              child: AnimatedTextKit(
                key: ValueKey<bool>(themeProvider.isDarkTheme),
                animatedTexts: [
                  TypewriterAnimatedText(
                    str.whatMovieWeGoWatch,
                    textStyle: theme.textTheme.titleLarge!.copyWith(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.15,
                      color: themeProvider.isDarkTheme
                          ? Colors.white
                          : Colors.black,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 1,
                pause: const Duration(milliseconds: 100),
              ),
            ),
            const SizedBox(height: 120),
            Image.asset('assets/images/watching-movie.png', height: 120),
          ],
        ),
      ),
    );
    final loading = Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.fourRotatingDots(
            color: theme.colorScheme.onTertiary,
            size: 40,
          ),
        ],
      ),
    );
    final textField = Expanded(
      child: TextFormField(
        cursorColor: theme.colorScheme.onTertiary,
        controller: _controller,
        maxLength: 50,
        buildCounter: (
          context, {
          required currentLength,
          required isFocused,
          required maxLength,
        }) {
          return const SizedBox();
        },
        style: theme.textTheme.bodyMedium!.copyWith(
          color: theme.colorScheme.onTertiary,
        ),
        decoration: InputDecoration(
          suffix: Text(
            '$_counter/50',
            style: theme.textTheme.labelSmall!.copyWith(
              color: theme.colorScheme.onTertiary,
            ),
          ),
          isDense: true,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          focusedBorder: theme.inputDecorationTheme.focusedBorder,
          enabledBorder: theme.inputDecorationTheme.enabledBorder,
          hintText: str.movieName,
          hintStyle: theme.textTheme.bodyMedium!.copyWith(
            color: theme.colorScheme.tertiary,
          ),
        ),
      ),
    );
    final submitButton = Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: IconButton(
        onPressed: () async {
          final search = _controller.text;
          if (search.trim().isEmpty) return;
          context.read<SearchMoviesBloc>().add(SearchMovies(search));
          context.read<MoviesBloc>().add(
                AddMovie(MovieRequestData(movies: [], prompt: search)),
              );
          _controller.clear();
        },
        icon: Icon(Icons.send, color: theme.colorScheme.onTertiary),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.colorScheme.onSecondary,
        elevation: 0,
        surfaceTintColor: theme.colorScheme.onSecondary.withOpacity(0.4),
        centerTitle: false,
        title: Text(
          str.movieRecommendation,
          style: theme.textTheme.titleLarge!.copyWith(
            color: theme.appBarTheme.titleTextStyle!.color,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () => context.read<MoviesBloc>().add(ClearMovie()),
            icon: Icon(
              Icons.add,
              color: theme.colorScheme.onPrimary,
            ),
          ),
          Switch(
            value: themeProvider.isDarkTheme,
            onChanged: (value) {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      bottomNavigationBar: Container(
        color: theme.colorScheme.onSecondary.withOpacity(0.9),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            const MovieRecommendationListWidget(),
            Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSecondary.withOpacity(0.8),
                borderRadius: BorderRadius.circular(100),
              ),
              height: 60,
              width: MediaQuery.of(context).size.width * 0.9,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    textField,
                    const SizedBox(width: 16),
                    submitButton
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              theme.colorScheme.onSecondary,
              theme.colorScheme.onSecondary.withOpacity(0.95),
              theme.colorScheme.onSecondary.withOpacity(0.9),
            ],
          ),
        ),
        child: Column(
          children: [
            BlocBuilder<MoviesBloc, MoviesState>(
              builder: (context, state) {
                context.read<MoviesBloc>().add(Movies([]));
                if (state is MoviesInitialState) {
                  return movieMessage;
                } else if (state is MoviesLoadingState) {
                  return loading;
                } else if (state is MoviesSuccessState) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.movies.length,
                      itemBuilder: (context, index) {
                        final movie = state.movies[index];
                        final promptWidget = BubbleSpecialThree(
                          text: movie.prompt,
                          color: theme.colorScheme.onSecondary,
                          tail: true,
                          textStyle: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.colorScheme.onPrimary,
                          ),
                        );
                        if (movie.error == null && movie.movies.isEmpty) {
                          return Container(
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: theme.colorScheme.surfaceContainer,
                            ),
                            child: Column(
                              children: [
                                promptWidget,
                                const SizedBox(height: 6),
                                BlocBuilder<SearchMoviesBloc,
                                    SearchMoviesState>(
                                  builder: (context, state) {
                                    if (state is SearchMoviesLoadingState) {
                                      return loading;
                                    }
                                    return const SizedBox();
                                  },
                                ),
                                const SizedBox(height: 6),
                              ],
                            ),
                          );
                        }
                        if (movie.error != null) {
                          return Container(
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: theme.colorScheme.surfaceContainer,
                            ),
                            child: Column(
                              children: [
                                promptWidget,
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    BubbleSpecialThree(
                                      text:
                                          movie.error ?? str.somethingWentWrong,
                                      color: theme.colorScheme.error,
                                      tail: true,
                                      isSender: false,
                                      textStyle:
                                          theme.textTheme.bodyMedium!.copyWith(
                                        color: theme.scaffoldBackgroundColor,
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.only(right: 8.0),
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.error,
                                        shape: BoxShape.circle,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          context.read<SearchMoviesBloc>().add(
                                                SearchMovies(movie.prompt),
                                              );
                                          context.read<MoviesBloc>().add(
                                                AddMovie(
                                                  MovieRequestData(
                                                    movies: [],
                                                    prompt: movie.prompt,
                                                    error: null,
                                                    isFailed: true,
                                                  ),
                                                ),
                                              );
                                        },
                                        child: Icon(
                                          Icons.refresh,
                                          color: theme.scaffoldBackgroundColor,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                        if (movie.movies.isEmpty) {
                          return Container(
                            margin: const EdgeInsets.only(top: 10),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: theme.colorScheme.surfaceContainer,
                            ),
                            child: Column(
                              children: [
                                promptWidget,
                                const SizedBox(height: 6),
                                BubbleSpecialThree(
                                  text: str.noResultsForThisSearch,
                                  color: theme.colorScheme.primary,
                                  tail: true,
                                  isSender: false,
                                  textStyle:
                                      theme.textTheme.bodyMedium!.copyWith(
                                    color: theme.scaffoldBackgroundColor,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: theme.colorScheme.surfaceContainer,
                          ),
                          child: Column(
                            children: [
                              promptWidget,
                              const SizedBox(height: 6),
                              MovieListWidget(movie.movies),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
