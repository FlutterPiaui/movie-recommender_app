import 'package:get_it/get_it.dart';
import 'package:movie_recommender_app/src/presentation/home/bloc/home_bloc.dart';

GetIt getIt = GetIt.instance;

Future<void> configureDependencies() async{
  // Register your dependencies here
   getIt.registerFactory<HomeBloc>(() => HomeBloc());
  // getIt.registerSingleton<YourDependency>(YourDependency());
}