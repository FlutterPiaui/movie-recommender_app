import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:movie_recommender_app/src/core/config/device_info.dart';
import 'package:movie_recommender_app/src/core/config/remote_config.dart';
import 'package:movie_recommender_app/src/di/di_setup.dart';
import 'package:movie_recommender_app/src/utils/dialog_utils.dart';
import 'package:movie_recommender_app/src/modules/movie_details/presenter/screen/movie_details_screen.dart';
import 'package:movie_recommender_app/src/modules/recommendations/presenter/screen/recommendations_screen.dart';
import 'package:pub_semver/pub_semver.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final packageInfo = getIt.get<DeviceInfo>();
  final remoteConfig = getIt.get<RemoteConfig>();
  late TextEditingController controller;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final requiredMinVersion = remoteConfig.getRequiredMinVersion();
      final deviceVersion = Version.parse(packageInfo.version);
      final requiredVersion = Version.parse(requiredMinVersion);
      final skipInstall = remoteConfig.getSkipInstallVersion();

      if (deviceVersion < requiredVersion) {
        DialogUtils.showInAppUpdateDialog(
          context: context,
          skipInstall: skipInstall,
        );
      }
    });
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
