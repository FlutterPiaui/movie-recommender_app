import 'package:get_it/get_it.dart';
import 'package:movie_recommender_app/src/presentation/home/bloc/home_bloc.dart';

import '../core/config/device_info.dart';
import '../core/config/remote_config.dart';

GetIt getIt = GetIt.instance;

// Register your dependencies here
Future<void> configureDependencies() async {
  getIt.registerFactory<HomeBloc>(() => HomeBloc());
  getIt.registerSingleton<DeviceInfo>(DeviceInfo());
  getIt.registerSingleton<RemoteConfig>(RemoteConfig());
}

Future<void> initDependencies() async {
  await getIt.get<RemoteConfig>().init();
  await getIt.get<DeviceInfo>().init();
}
