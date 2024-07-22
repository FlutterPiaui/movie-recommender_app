import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_recommender_app/src/core/config/device_info.dart';
import 'package:movie_recommender_app/src/core/config/remote_config.dart';
import 'package:movie_recommender_app/src/di/di_setup.dart';
import 'package:movie_recommender_app/src/presentation/movie_details/screen/movie_details_screen.dart';
import 'package:movie_recommender_app/src/presentation/recommendations/screen/recommendations_screen.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final packageInfo = getIt.get<DeviceInfo>();
  final remoteConfig = getIt.get<RemoteConfig>();

  Future<void> _openUpdateApp() async {
    //Update link after deploy
    final url = Platform.isIOS
        ? 'https://www.apple.com/br/store'
        : 'https://play.google.com/store/games?hl=pt_BR';

    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final requiredMinVersion = remoteConfig.getRequiredMinVersion();
      final deviceVersion = Version.parse(packageInfo.version);
      final requiredVersion = Version.parse(requiredMinVersion);
      if (deviceVersion < requiredVersion) _showInAppUpdateDialog();
    });
    super.initState();
  }

  void _showInAppUpdateDialog() {
    final str = AppLocalizations.of(context)!;
    final skipInstall = remoteConfig.getSkipInstallVersion();
    final theme = Theme.of(context);
    showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog.adaptive(
          titlePadding: EdgeInsets.zero,
          title: Row(
            children: [
              Image.asset('assets/images/logo_app_gemini.png', height: 60),
              Expanded(
                child: Text(str.newVersionAvailable,
                    style: theme.textTheme.bodyMedium,),
              ),
            ],
          ),
          actions: [
            if (skipInstall)
              TextButton(
                onPressed: () => context.pop(),
                child: Text(str.skip, style: theme.textTheme.bodySmall),
              ),
            TextButton(
              onPressed: () async => await _openUpdateApp(),
              child: Text(
                str.install,
                style: theme.textTheme.bodySmall!.copyWith(
                  color: theme.primaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

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
