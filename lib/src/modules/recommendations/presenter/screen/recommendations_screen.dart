import 'package:flutter/material.dart';

class RecommendationsScreen extends StatefulWidget {
  static const routeName = '/recommendations';
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Recommendations'),
      ),
      body: const Column(
        children: [
          Center(
            child: Text(
              'Recomendações de filmes aqui!',
            ),
          ),
        ],
      ),
    );
  }
}
