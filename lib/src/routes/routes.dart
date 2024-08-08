import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_recommender_app/src/modules/home/screen/home_screen.dart';
import 'package:movie_recommender_app/src/modules/movie_details/presenter/screen/movie_details_screen.dart';
import 'package:movie_recommender_app/src/modules/movie_details/presenter/screen/trailler_page_player.dart';
import 'package:movie_recommender_app/src/modules/recommendations/presenter/screen/recommendations_screen.dart';
import 'package:movie_recommender_app/src/modules/splash/screen/splash_screen.dart';

final rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: SplashScreen.routeName,
  redirect: (context, state) {
    // Redirecionador de rotas caso o usuário não esteja logado, por exemplo
    return null;
  },
  routes: <RouteBase>[
    GoRoute(
      path: SplashScreen.routeName,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: HomeScreen.routeName,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RecommendationsScreen.routeName,
      builder: (context, state) => const RecommendationsScreen(),
      routes: const [
        // * Exemplo de rota aninhada
        // GoRoute(
        //   path: Exemplo.routeName,
        //   builder: (context, state) => Exemplo(
        //     args: state.extra as ExemploArgs?,
        //   ),
        // ),
      ],
    ),
    // Others
    GoRoute(
      path: MovieDetailsScreen.routeName,
      builder: (context, state) => MovieDetailsScreen(
        movieName: state.uri.queryParameters['movieName']!,
      ),
    ),
    GoRoute(
      path: PlayerYoutube.routeName,
      builder: (context, state) => PlayerYoutube(
        urlTrailler: state.uri.queryParameters['urlMovie'],
      ),
    ),
  ],
);
