import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_recommender_app/src/presentation/home/bloc/home_event.dart';
import 'package:movie_recommender_app/src/presentation/home/bloc/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<GetHomeRecommendations>(_fetch);
  }

  Future<void> _fetch(
    GetHomeRecommendations event,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState());
    // final result = await _homeRepository.getHomeRecommendations();
  }
}
