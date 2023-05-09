import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/hot_and_new%20_resp/hot_and_new_service.dart';
import 'package:netflix/domain/hot_and_new%20_resp/models/hot_and_new_resp.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService homeService;

  HomeBloc(this.homeService) : super(HomeState.initial()) {
    on<GetHomeScreenData>((event, emit) async {
      //send loadig to ui
      emit(state.copyWith(isLoading: true, isError: false));

      //get data

      final movieResult = await homeService.getHotAndNewMovieData();
      final tvResult = await homeService.getHotAndNewTVData();

      //transform data
      final state1 = movieResult.fold((l) {
        return const HomeState(
          pastYearMovieList: [],
          trendingMovieList: [],
          tenseMovieList: [],
          southIndianMovieList: [],
          trendingTvList: [],
          isLoading: false,
          isError: true,
        );
      }, (r) {
        final pastYearList = r.results;
        final trendingList = r.results;
        final tenseList = r.results;
        final southList = r.results;
        pastYearList.shuffle();
        trendingList.shuffle();
        tenseList.shuffle();
        southList.shuffle();
        return HomeState(
          pastYearMovieList: pastYearList,
          trendingMovieList: trendingList,
          tenseMovieList: tenseList,
          southIndianMovieList: southList,
          trendingTvList: state.trendingTvList,
          isLoading: false,
          isError: false,
        );
      });
      emit(state1);
      final state2 = tvResult.fold((l) {
        return const HomeState(
          pastYearMovieList: [],
          trendingMovieList: [],
          tenseMovieList: [],
          southIndianMovieList: [],
          trendingTvList: [],
          isLoading: false,
          isError: true,
        );
      }, (r) {
        final topTenList = r.results;
        return HomeState(
          pastYearMovieList: state.pastYearMovieList,
          trendingMovieList: state.trendingMovieList,
          tenseMovieList: state.tenseMovieList,
          southIndianMovieList: state.southIndianMovieList,
          trendingTvList: topTenList,
          isLoading: false,
          isError: false,
        );
      });
      //send t ui
      emit(state2);
    });
  }
}
