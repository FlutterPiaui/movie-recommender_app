import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_recommender_app/src/core/theme/app_theme.dart';
import 'package:movie_recommender_app/src/di/di_setup.dart';
import 'package:movie_recommender_app/src/routes/routes.dart';

void main() async {
  await configureDependencies();
  final deviceLanguage = Platform.localeName.split('_');
  AppLocalizations.delegate.load(Locale(deviceLanguage[0]));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerDelegate: router.routerDelegate,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: AppTheme.theme,
    );
  }
}
