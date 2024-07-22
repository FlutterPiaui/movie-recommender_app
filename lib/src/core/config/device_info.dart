import 'package:package_info_plus/package_info_plus.dart';

class DeviceInfo {
  late String version;

  Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
  }
}
