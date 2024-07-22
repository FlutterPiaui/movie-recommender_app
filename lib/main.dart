import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:movie_recommender_app/firebase_options.dart';
import 'package:movie_recommender_app/src/core/theme/app_theme.dart';
import 'package:movie_recommender_app/src/di/di_setup.dart';
import 'package:movie_recommender_app/src/routes/routes.dart';

void main() async {
  runZonedGuarded<Future<void>>(
    () async {
      WidgetsFlutterBinding.ensureInitialized();

      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
      await FirebaseCrashlytics.instance
          .setCrashlyticsCollectionEnabled(!kDebugMode);

      FlutterError.onError = (details) {
        FlutterError.presentError(details);

        final information = details.informationCollector?.call() ?? [];

        FirebaseCrashlytics.instance.recordError(
          details.exceptionAsString(),
          details.stack,
          reason: details.context?.toStringDeep(minLevel: DiagnosticLevel.info),
          information: information,
          printDetails: false,
          fatal: true,
        );
      };
      await configureDependencies();
      final deviceLanguage = Platform.localeName.split('_')[0];
      await AppLocalizations.delegate.load(Locale(deviceLanguage));
      runApp(const MyApp());
    },
    (error, stack) =>
        FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),
  );
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
