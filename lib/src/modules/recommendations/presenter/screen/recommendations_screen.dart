import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie_recommender_app/src/modules/recommendations/presenter/bloc/movies/movies_event.dart';
import 'package:movie_recommender_app/src/modules/recommendations/presenter/bloc/search_movies/search_movies_state.dart';
import 'package:movie_recommender_app/src/presentation/home/screen/widgets/movie_list_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/shared/widgets/others/custom_app_bar.dart';
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
  @override
  void initState() {
    context.read<MoviesBloc>().add(Movies([]));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final str = AppLocalizations.of(context)!;
    final controller = TextEditingController();

    final movieMessage = Expanded(
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 30.0, horizontal: 16),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    str.whatMovieWeGoWatch,
                    textStyle: theme.textTheme.titleLarge!.copyWith(
                      fontSize: 36,
                    ),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
                totalRepeatCount: 1,
                pause: const Duration(milliseconds: 100),
              ),
            ),
            const SizedBox(height: 120),
            Image.asset('assets/images/logo_app_gemini.png', height: 100),
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
            color: theme.colorScheme.onSecondary,
            size: 60,
          ),
        ],
      ),
    );

    final textField = Expanded(
      child: TextFormField(
        cursorColor: theme.colorScheme.onSurface,
        controller: controller,
        maxLength: 50,
        buildCounter: (
          context, {
          required currentLength,
          required isFocused,
          required maxLength,
        }) {
          return Text(
            '$currentLength/$maxLength',
            style: theme.textTheme.labelSmall,
          );
        },
        decoration: InputDecoration(
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

    final submitButton = IconButton(
      onPressed: () async {
        final search = controller.text;
        if (search.trim().isEmpty) return;
        context.read<SearchMoviesBloc>().add(SearchMovies(search));
        controller.clear();
      },
      icon: Icon(Icons.send, color: theme.colorScheme.onSurface),
    );

    final bottomNavigationBar = Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 20, top: 8),
      child: Row(
        children: [textField, const SizedBox(width: 16), submitButton],
      ),
    );

    return Scaffold(
      appBar: const CustomAppBar(),
      bottomNavigationBar: bottomNavigationBar,
      body: Column(
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
                          color: theme.scaffoldBackgroundColor,
                        ),
                      );
                      if (movie.error != null) {
                        return Container(
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          color: Colors.grey.shade200,
                          child: Column(
                            children: [
                              promptWidget,
                              const SizedBox(height: 6),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  BubbleSpecialThree(
                                    text: movie.error ?? str.somethingWentWrong,
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
                                    decoration: BoxDecoration(
                                      color: theme.colorScheme.error,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.clear,
                                      color: theme.scaffoldBackgroundColor,
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
                          color: Colors.grey.shade200,
                          child: Column(
                            children: [
                              promptWidget,
                              const SizedBox(height: 6),
                              BubbleSpecialThree(
                                text: str.noResultsForThisSearch,
                                color: theme.colorScheme.primary,
                                tail: true,
                                isSender: false,
                                textStyle: theme.textTheme.bodyMedium!.copyWith(
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
                        color: Colors.grey.shade200,
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
          BlocBuilder<SearchMoviesBloc, SearchMoviesState>(
            builder: (context, state) {
              if (state is SearchMoviesLoadingState) return loading;
              return const SizedBox();
            },
          ),
        ],
      ),
    );
  }
}
