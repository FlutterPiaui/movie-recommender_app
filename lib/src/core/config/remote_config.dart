import 'package:firebase_remote_config/firebase_remote_config.dart';

class RemoteConfig {
  final remoteConfig = FirebaseRemoteConfig.instance;

  Future<void> init() async {
    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );

    await remoteConfig.setDefaults(
      const {'requiredMinimumVersion': '1.0.0', 'skipInstallVersion': false},
    );

    await remoteConfig.fetchAndActivate();

    remoteConfig.onConfigUpdated.listen((event) async {
      await remoteConfig.activate();
    });
  }

  String getRequiredMinVersion() =>
      remoteConfig.getString('requiredMinimumVersion');

  bool getSkipInstallVersion() => remoteConfig.getBool('skipInstallVersion');
}
