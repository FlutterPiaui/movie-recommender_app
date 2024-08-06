import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:movie_recommender_app/src/core/client/dio_client_service.dart';
import 'package:movie_recommender_app/src/modules/movie_details/presenter/bloc/movie_details_bloc.dart';
import '../modules/home/bloc/home_bloc.dart';
import 'package:movie_recommender_app/src/modules/recommendations/data/repositories/recommendation_repository.dart';
import '../modules/movie_details/data/repositories/movie_details_repository.dart';
import '../modules/movie_details/domain/repositories/movie_details_repository.dart';
import '../modules/recommendations/domain/repositories/recommendation_repository.dart';

import '../core/config/device_info.dart';
import '../core/config/remote_config.dart';
import '../modules/recommendations/presenter/bloc/search_movies_bloc.dart';

GetIt getIt = GetIt.instance;

// Register your dependencies here
Future<void> configureDependencies() async {
  getIt.registerFactory<HomeBloc>(() => HomeBloc());
  getIt.registerFactory<MovieDetailsBloc>(
      () => MovieDetailsBloc(getIt<MovieDetailsRepository>()));
  getIt.registerFactory<SearchMoviesBloc>(
      () => SearchMoviesBloc(getIt.get<RecommendationRepository>()));
  getIt.registerSingleton<DeviceInfo>(DeviceInfo());
  getIt.registerSingleton<RemoteConfig>(RemoteConfig());
  getIt.registerSingleton<ApiClientDio>(ApiClientDio(Dio()));
  getIt.registerSingleton<RecommendationRepository>(
    RecommendationRepositoryImpl(getIt.get<ApiClientDio>()),
  );
  getIt.registerSingleton<MovieDetailsRepository>(
    MovieDetailsRepositoryImpl(getIt.get<ApiClientDio>()),
  );
}

Future<void> initDependencies() async {
  await getIt.get<RemoteConfig>().init();
  await getIt.get<DeviceInfo>().init();
}
