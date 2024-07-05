import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_recommender_app/src/presentation/movie_details/screen/movie_details_screen.dart';
import 'package:movie_recommender_app/src/presentation/recommendations/screen/recommendations_screen.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('SEARCH MOVIES'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            navButton(
              title: 'Recommendations',
              route: RecommendationsScreen.routeName,
            ),
            navButton(
              title: 'Movie Details',
              route: MovieDetailsScreen.routeName,
            ),
          ],
        ),
      ),
    );
  }

  Widget navButton({required String title, required String route}) {
    return CupertinoButton(
      child: Text(title),
      onPressed: () => context.push(route),
    );
  }
}
